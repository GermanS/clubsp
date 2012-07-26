package ClubSpain::Controller::BackOffice::BaseRole;
use strict;
use warnings;
use utf8;
use MooseX::MethodAttributes::Role;
use namespace::autoclean;

use ClubSpain::Constants qw(:all);
use ClubSpain::Message;

sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(template => $self->template);
};


sub end :ActionClass('RenderView') {
};


sub enable :Chained('id') :PathPart('enable') :Args(0) {
    my ($self, $c) = @_;

    $self->get_object($c)->update({
        is_published => ENABLE
    });
    $c->res->redirect($c->uri_for('default'));
};


sub disable :Chained('id') :PathPart('disable') :Args(0) {
    my ($self, $c) = @_;

    $self->get_object($c)->update({
        is_published => DISABLE
    });
    $c->res->redirect($c->uri_for('default'));
};


sub get_object :Private  {
    my ($self, $c) = @_;

    return $c->stash->{'object'};
};


sub id :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;

    my $object;
    eval {
        $object = $c->model($self->model)->fetch_by_id($id);
        $c->stash( object => $object );
    };

    if ($@) {
        $self->show_message(context => $c, error => $@);
        $c->detach('default');
    }
};


sub delete :Chained('id') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    eval { $c->model($self->model)->delete( $self->get_object($c)->id ); };
    $self->show_message(context => $c, error => $@);

    $c->res->redirect($c->uri_for('default'));
};

#показать ошибки при работе с данными вне формы
sub show_message :Private {
    my ($self, %params) = @_;

    $params{'error'} ? $self->show_error_message(%params)
                     : $self->show_successful_message(%params);
};

sub show_error_message :Private {
    my ($self, %params) = @_;

    if ($params{'error'} = Exception::Class->caught('ClubSpain::Exception::Validation')) {
        $params{'сontext'}->stash( message => ClubSpain::Message->warning( $params{'error'}->message ) );
    } elsif ($params{'error'} = Exception::Class->caught('ClubSpain::Exception::Storage')) {
        $params{'context'}->stash( message => ClubSpain::Message->error( $params{'error'}->message ));
    } else {
        $params{'context'}->stash( message => ClubSpain::Message->error( $@ ) );
    }
};

sub show_successful_message :Private {
    my ($self, %params) = @_;

    $params{'context'}->stash( message => ClubSpain::Message->ok( MESSAGE_OK ) );
};

1;
