package ClubSpain::Controller::BackOffice::Country;
use strict;
use warnings;
use utf8;

use constant {
    DISABLE     => 0,
    ENABLE      => 1,
    MESSAGE_OK  => 'Операция успешно выполнена',
};

use parent qw(Catalyst::Controller::HTML::FormFu);
use ClubSpain::Design::Country;



sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(template => 'backoffice/country.tt2')
}



sub default :Path {
    my ($self, $c) = @_;

    $c->stash(iterator => ClubSpain::Design::Country->list());
}



sub end :ActionClass('RenderView') {}



sub base :Chained('/backoffice/base') :PathPart('country') :CaptureArgs(0) {};



sub id :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;

    my $country;
    eval {
        $country = ClubSpain::Design::Country->fetch_by_id($id);
        $c->stash( country => $country );
    };

    if ($@) {
        $self->process_error($c, $@) if $@;
        $c->response->redirect($c->uri_for('default'));
        $c->detach();
    }
};



sub enable :Chained('id') :PathPart('enable') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{'country'}->update({
        is_published => ENABLE
    });
    $c->res->redirect($c->uri_for('default'));
}



sub disable :Chained('id') :PathPart('disable') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{'country'}->update({
        is_published => DISABLE
    });
    $c->res->redirect($c->uri_for('default'));
}


sub process_error {
    my ($self, $c, $e) = @_;

    if ($e = Exception::Class->caught('ClubSpain::Exception::Validation')) {
        $c->stash( message => $e->message );
    } elsif ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
        $c->stash( message => $e->message );
    } else {
        $c->stash( message => $@ );
    }
}

sub successful_message {
    my ($self, $c) = @_;

    $c->stash( message => MESSAGE_OK );
}

1;
