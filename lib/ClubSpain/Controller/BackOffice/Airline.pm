package ClubSpain::Controller::BackOffice::Airline;
use strict;
use warnings;
use utf8;

use parent qw(Catalyst::Controller::HTML::FormFu);
use ClubSpain::Constants qw(:all);

sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(
        template => 'backoffice/airline.tt2',
    );
};

sub default :Path {
    my ($self, $c) = @_;

    $c->stash(
        iterator => $c->model('Airline')->list({})
    );
};

sub end :ActionClass('RenderView') {};

sub base :Chained('/backoffice/base') :PathPart('airline') :CaptureArgs(0) {};

sub id :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;

    my $airline;
    eval {
        $airline = $c->model('Airline')->fetch_by_id($id);
        $c->stash( airline => $airline );
    };

    if ($@) {
        $self->process_error($c, $@) if $@;
        $c->response->redirect($c->uri_for('default'));
        $c->detach();
    }
};

sub enable :Chained('id') :PathPart('enable') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{'airline'}->update({
        is_published => ENABLE
    });
    $c->res->redirect($c->uri_for('default'));
};

sub disable :Chained('id') :PathPart('disable') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{'airline'}->update({
        is_published => DISABLE
    });
    $c->res->redirect($c->uri_for('default'));
};

sub delete :Chained('id') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    eval {
        $c->model('Airline')->delete($c->stash->{'airline'}->id);
    };

    if ($@) {
        $self->process_error($c, $@);
    } else {
        $self->successful_message($c);
    }

    $c->res->redirect($c->uri_for('default'));
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

    my $form = $self->form();
    $form->load_config_filestem('backoffice/airline_form');
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
        form    => $self->load_add_form($c),
        template => 'backoffice/airline_form.tt2'
    );
};

sub insert :Private {
    my ($self, $c) = @_;

    eval {
        my $airline = $c->model('Airline')->new(
            iata     => $c->request->param('iata'),
            icao     => $c->request->param('icao'),
            name     => $c->request->param('name'),
            is_published => ENABLE,
        );
        $airline->create();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
        if $@;
};

sub load_upd_form :Private {
    my ($self, $c) = @_;

    my $form = $self->load_add_form($c);
    my $airline = $c->stash->{'airline'};

    $form->get_element({ name => 'iata' })->value($airline->iata);
    $form->get_element({ name => 'icao' })->value($airline->icao);
    $form->get_element({ name => 'name' })->value($airline->name);

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
        form => $self->load_upd_form($c),
        template => 'backoffice/airline_form.tt2'
    );
};

sub update :Private {
    my ($self, $c) = @_;

    eval {
        my $airline = $c->model('Airline')->new(
            id          => $c->stash->{'airline'}->id,
            icao        => $c->request->param('icao'),
            iata        => $c->request->param('iata'),
            name        => $c->request->param('name'),
            is_published=> $c->stash->{'airline'}->is_published,
        );
        $airline->update();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
         if $@;
};

1;
