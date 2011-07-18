package ClubSpain::Controller::BackOffice::Flight;
use strict;
use warnings;
use utf8;
use parent qw(ClubSpain::Controller::BackOffice::FormFu);
use ClubSpain::Constants qw(:all);

sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(
        template => 'backoffice/flight/flight.tt2',
    );
};

sub default :Path {
    my ($self, $c) = @_;

    if ($c->request->param('AirportOfDeparture') && $c->request->param('AirportOfArrival')) {
        my $iterator = $c->model('Flight')->search({
            departure_airport_id    => $c->request->param('AirportOfDeparture'),
            destination_airport_id  => $c->request->param('AirportOfArrival')
        }, {
            order_by => [qw(airline_id code)]
        });

        $c->stash( iterator => $iterator );
        $self->setup_stash_from_request($c);
    }
};

sub base :Chained('/backoffice/base') :PathPart('flight') :CaptureArgs(0) {}

#match /backoffice/flight/*
sub id :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $id) = @_;

    my $flight;
    eval {
        $flight = $c->model('Flight')->fetch_by_id($id);
        $c->stash( flight => $flight );
        $self->setup_stash_from_data($c);
    };

    if ($@) {
        $self->process_error($c, $@) if $@;
        $c->response->redirect($c->uri_for($self->action_for('index')));
        $c->detach();
    }
};

sub create :Local {
    my ($self, $c) = @_;
    $self->setup_stash_from_request($c);

    my $form = $self->load_add_form($c);

    if ($form->submitted_and_valid()) {
        $self->insert($c);
    }

    $c->stash(
        form     => $self->load_add_form($c),
        template => 'backoffice/flight/flight_form.tt2'
    );
};

sub edit :Chained('id') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    my $form = $self->load_upd_form($c);
    if ($form->submitted_and_valid()) {
        $self->update($c);
    }

    $c->stash(
        form => $self->load_upd_form($c),
        template => 'backoffice/flight/flight_form.tt2'
    );
};

sub update :Private {
    my ($self, $c) = @_;

    eval {
        my $flight = $c->model('Flight')->new(
            id                      => $c->stash->{'flight'}->id,
            departure_airport_id    => $c->request->param('AirportOfDeparture'),
            destination_airport_id  => $c->request->param('AirportOfArrival'),
            airline_id              => $c->request->param('airline_id'),
            code                    => $c->request->param('code'),
            is_published            => $c->stash->{'flight'}->is_published,
        );
        $flight->update();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
         if $@;
};

sub load_add_form :Private {
    my ($self, $c) = @_;

    $c->stash->{'current_model_instance'} =
        $c->model('Airline')->schema()->resultset('Airline');

    my $form = $self->form();
    $form->load_config_filestem('backoffice/flight_form');
    $form->get_element({ name => 'CountryOfDeparture' })
         ->value( $c->stash->{'CountryOfDeparture'} );
    $form->get_element({ name => 'CityOfDeparture' })
         ->value( $c->stash->{'CityOfDeparture'} );
    $form->get_element({ name => 'AirportOfDeparture' })
         ->value( $c->stash->{'AirportOfDeparture'} );
    $form->get_element({ name => 'CountryOfArrival' })
         ->value( $c->stash->{'CountryOfArrival'} );
    $form->get_element({ name => 'CityOfArrival' })
         ->value( $c->stash->{'CityOfArrival'} );
    $form->get_element({ name => 'AirportOfArrival' })
         ->value( $c->stash->{'AirportOfArrival'} );
    $form->process();

    return $form;
};

sub load_upd_form :Private {
    my ($self, $c) = @_;
    my $flight = $c->stash->{'flight'};

    my $form = $self->load_add_form($c);
    $form->get_element({ name => 'airline_id' })
         ->value($flight->airline_id);
    $form->get_element({ name => 'code' })
         ->value($flight->code);
    $form->process();

    return $form;
};

sub insert :Private {
    my ($self, $c) = @_;

    eval {
        my $flight = $c->model('Flight')->new(
            departure_airport_id    => $c->request->param('AirportOfDeparture'),
            destination_airport_id  => $c->request->param('AirportOfArrival'),
            airline_id              => $c->request->param('airline_id'),
            code                    => $c->request->param('code'),
            is_published            => ENABLE,
        );
        $flight->create();

        $self->successful_message($c);
    };

    $self->process_error($c, $@)
        if $@;
};

sub enable :Chained('id') :PathPart('enable') :Args(0) {
    my ($self, $c) = @_;

    my $flight = $c->stash->{'flight'};
    $flight->update({ is_published => ENABLE });

    $self->setup_request_from_stash($c);
    $c->detach('default');
};

sub disable :Chained('id') :PathPart('disable') :Args(0) {
    my ($self, $c) = @_;

    my $flight = $c->stash->{'flight'};
    $flight->update({ is_published => DISABLE });

    $self->setup_request_from_stash($c);
    $c->detach('default');
};

# match /backoffice/flight/*/delete
sub delete :Chained('id') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    my $flight = $c->stash->{'flight'};
    $self->setup_request_from_stash($c);
    eval {
        $c->model('Flight')->delete($flight->id);
        $self->successful_message($c);
    };

    $self->process_error($c, $@)
         if $@;

    $c->detach('default');
};

sub setup_stash_from_request :Private {
    my ($self, $c) = @_;

    my @param = qw(CountryOfDeparture
                   CityOfDeparture
                   AirportOfDeparture
                   CountryOfArrival
                   CityOfArrival
                   AirportOfArrival);

    $c->stash($_ => $c->request->param($_))
        foreach (@param);
};

sub setup_stash_from_data :Private {
    my ($self, $c) = @_;

    my $flight = $c->stash->{'flight'};
    $c->stash({
        CountryOfDeparture => $flight->departure_airport->city->country->id,
        CityOfDeparture    => $flight->departure_airport->city->id,
        AirportOfDeparture => $flight->departure_airport_id,
        CountryOfArrival   => $flight->destination_airport->city->country->id,
        CityOfArrival      => $flight->destination_airport->city->id,
        AirportOfArrival   => $flight->destination_airport_id,
    });
};

sub setup_request_from_stash :Private {
    my ($self, $c) = @_;

    my @param = qw(CountryOfDeparture
                   CityOfDeparture
                   AirportOfDeparture
                   CountryOfArrival
                   CityOfArrival
                   AirportOfArrival);

    $c->request->param($_, $c->stash->{$_})
        foreach (@param);
};

1;
