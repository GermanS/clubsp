package ClubSpain::Controller::BackOffice::Terminal;
use strict;
use warnings;
use utf8;

use parent qw(Catalyst::Controller::HTML::FormFu);
use ClubSpain::Constants qw(:all);
use ClubSpain::Design::Airport;
use ClubSpain::Design::Terminal;


sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(
        template     => 'backoffice/terminal.tt2',
        airport_list => ClubSpain::Design::Airport->list({})
    );
};

sub default :Path {
    my ($self, $c) = @_;

    $c->stash(iterator => ClubSpain::Design::Terminal->list({}));
};

sub end :ActionClass('RenderView') {};

sub base :Chained('/backoffice/base') :PathPart('terminal') :CaptureArgs(0) {};

sub id :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;

    my $terminal;
    eval {
        $terminal = ClubSpain::Design::Terminal->fetch_by_id($id);
        $c->stash( terminal => $terminal );
    };

    if ($@) {
        $self->process_error($c, $@) if $@;
        $c->response->redirect($c->uri_for('default'));
        $c->detach();
    }
};

sub enable :Chained('id') :PathPart('enable') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{'terminal'}->update({
        is_published => ENABLE
    });
    $c->res->redirect($c->uri_for('browse', $c->stash->{'terminal'}->airport_id));
};

sub disable :Chained('id') :PathPart('disable') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{'terminal'}->update({
        is_published => DISABLE
    });
    $c->res->redirect($c->uri_for('browse', $c->stash->{'terminal'}->airport_id));
};

sub delete :Chained('id') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    eval {
        ClubSpain::Design::Terminal->delete($c->stash->{'terminal'}->id);
    };

    if ($@) {
        $self->process_error($c, $@);
    } else {
        $self->successful_message($c);
    }

    $c->res->redirect($c->uri_for('browse', $c->stash->{'terminal'}->airport_id));
};

sub process_error {
    my ($self, $c, $e) = @_;

    if ($e = Exception::Class->caught('ClubSpain::Exception::Validation')) {
        $c->stash( message => $e->message );
    } elsif ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
        $c->stash( message => $e->message );
    } else {
        $c->stash( message => $@ );
    }
};

sub successful_message {
    my ($self, $c) = @_;

    $c->stash( message => MESSAGE_OK );
};

sub load_add_form :Private  {
    my ($self, $c) = @_;

    $c->stash->{'current_model_instance'} =
        ClubSpain::Design::Airport->schema()->resultset('Airport');

    my $form = $self->form();
    $form->load_config_filestem('backoffice/terminal_form');
    $form->process();

    return $form;
};

sub create :Local {
    my ($self, $c) = @_;

    my $form = $self->load_add_form($c);
    if ($form->submitted_and_valid()) {
        $self->insert($c);
    }

    $c->stash(
        form     => $self->load_add_form($c),
        template => 'backoffice/terminal_form.tt2'
    );
};

sub insert :Private {
    my ($self, $c) = @_;

    eval {
        my $country = ClubSpain::Design::Terminal->new(
            airport_id   => $c->request->param('airport_id'),
            name         => $c->request->param('name'),
            is_published => ENABLE,
        );
        $country->create();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
        if $@;
};

sub load_upd_form :Private {
    my ($self, $c) = @_;

    my $form = $self->load_add_form($c);
    my $terminal = $c->stash->{'terminal'};

    $form->get_element({ name => 'airport_id' })->value($terminal->airport_id);
    $form->get_element({ name => 'name' })->value($terminal->name);

    $form->process;

    return $form;
};

sub edit :Chained('id') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    my $form = $self->load_upd_form($c);
    if ($form->submitted_and_valid()) {
        $self->update($c);
    }

    $c->stash(
        form     => $self->load_upd_form($c),
        template => 'backoffice/terminal_form.tt2'
    );
};

sub update :Private {
    my ($self, $c) = @_;

    eval {
        my $terminal = ClubSpain::Design::Terminal->new(
            id           => $c->stash->{'terminal'}->id,
            airport_id   => $c->request->param('airport_id'),
            name         => $c->request->param('name'),
            is_published => $c->stash->{'terminal'}->is_published,
        );
        $terminal->update();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
         if $@;
};

sub browse :Local :Args(1) {
    my ($self, $c, $airport) = @_;

    $c->stash(
        iterator => ClubSpain::Design::Terminal->list({airport_id => $airport})
    );
}

1;
