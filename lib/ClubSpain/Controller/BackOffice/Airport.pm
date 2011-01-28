package ClubSpain::Controller::BackOffice::Airport;
use strict;
use warnings;
use utf8;

use parent qw(Catalyst::Controller::HTML::FormFu);
use ClubSpain::Constants qw(:all);

sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(
        template     => 'backoffice/airport.tt2',
        country_list => $c->model('Country')->list({})
    );
};

sub default :Path {
    my ($self, $c) = @_;

    $c->stash(
        iterator => $c->model('Airport')->list({})
    );
};

sub end :ActionClass('RenderView') {};

sub base :Chained('/backoffice/base') :PathPart('airport') :CaptureArgs(0) {};

sub id :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;

    my $port;
    eval {
        $port = $c->model('Airport')->fetch_by_id($id);
        $c->stash( port => $port );
    };

    if ($@) {
        $self->process_error($c, $@) if $@;
        $c->response->redirect($c->uri_for('default'));
        $c->detach();
    }
};

sub enable :Chained('id') :PathPart('enable') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{'port'}->update({
        is_published => ENABLE
    });
    $c->res->redirect($c->uri_for('city', $c->stash->{'port'}->city_id));
};

sub disable :Chained('id') :PathPart('disable') :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{'port'}->update({
        is_published => DISABLE
    });
    $c->res->redirect($c->uri_for('city', $c->stash->{'port'}->city_id));
};

sub delete :Chained('id') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    eval {
        $c->model('Airport')->delete($c->stash->{'port'}->id);
    };

    if ($@) {
        $self->process_error($c, $@);
    } else {
        $self->successful_message($c);
    }

    $c->res->redirect($c->uri_for('city', $c->stash->{'port'}->city_id));
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
        $c->model('City')->schema()->resultset('City');

    my $form = $self->form();
    $form->load_config_filestem('backoffice/airport_form');
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
        template => 'backoffice/airport_form.tt2'
    );
};

sub insert :Private {
    my ($self, $c) = @_;

    eval {
        my $port = $c->model('Airport')->new(
            city_id  => $c->request->param('city_id'),
            iata     => $c->request->param('iata'),
            icao     => $c->request->param('icao'),
            name     => $c->request->param('name'),
            is_published => ENABLE,
        );
        $port->create();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
        if $@;
};

sub load_upd_form :Private {
    my ($self, $c) = @_;

    my $form = $self->load_add_form($c);
    my $port = $c->stash->{'port'};

    $form->get_element({ name => 'city_id' })->value($port->city_id);
    $form->get_element({ name => 'iata' })->value($port->iata);
    $form->get_element({ name => 'icao' })->value($port->icao);
    $form->get_element({ name => 'name' })->value($port->name);

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
        template => 'backoffice/airport_form.tt2'
    );
};

sub update :Private {
    my ($self, $c) = @_;

    eval {
        my $port = $c->model('Airport')->new(
            id          => $c->stash->{'port'}->id,
            city_id     => $c->request->param('city_id'),
            icao        => $c->request->param('icao'),
            iata        => $c->request->param('iata'),
            name        => $c->request->param('name'),
            is_published=> $c->stash->{'port'}->is_published,
        );
        $port->update();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
         if $@;
};

sub country :Local :Args(1) {
    my ($self, $c, $country_id) = @_;

    $c->stash(
        selected_country => $c->model('Country')->fetch_by_id($country_id)
    );

    unless ($c->stash->{'iterator'}) {
        $c->stash(
            iterator => $c->model('Airport')->list(
                { 'city.country_id' => $country_id },
                { join => 'city' }
            )
        );
    }
}

sub city :Local :Args(1) {
    my ($self, $c, $city_id) = @_;

    my $city = $c->model('City')->fetch_by_id($city_id);
    $c->stash( selected_city => $city );

    $self->country($c, $city->country_id);

    $c->stash(
        iterator => $c->model('Airport')->list({
            city_id => $city_id
        })
    );
}

1;
