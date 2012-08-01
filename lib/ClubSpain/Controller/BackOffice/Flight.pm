package ClubSpain::Controller::BackOffice::Flight;
use Moose;
use namespace::autoclean;
BEGIN {
    extends 'Catalyst::Controller'
};
with 'ClubSpain::Controller::BackOffice::BaseRole';

use ClubSpain::Constants qw(:all);
use ClubSpain::Form::BackOffice::Flight;
sub form :Private {
    my ($self, $model) = @_;
    return ClubSpain::Form::BackOffice::Flight->new( model_object => $model );
};

has 'template' => (
    is => 'ro',
    default => 'backoffice/flight/flight.tt2'
);

has 'template_form' => (
    is => 'ro',
    default => 'backoffice/flight/flight_form.tt2'
);

has 'model' => (
    is => 'ro',
    default => 'Flight',
);

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

sub create :Local {
    my ($self, $c) = @_;
    $self->setup_stash_from_request($c);

    my $flight = $c->model($self->model)->new();
    my $form = $self->form($flight);

    my $is_posted = exists ($c->request->parameters->{'code'}) &&
                    exists ($c->request->parameters->{'airline_id'});

    $form->process(
        posted => $is_posted,
        init_object => {
            CountryOfDeparture => $c->request->param('CountryOfDeparture'),
            CityOfDeparture    => $c->request->param('CityOfDeparture'),
            AirportOfDeparture => $c->request->param('AirportOfDeparture'),
            CountryOfArrival   => $c->request->param('CountryOfArrival'),
            CityOfArrival      => $c->request->param('CityOfArrival'),
            AirportOfArrival   => $c->request->param('AirportOfArrival'),
        },
        params => $c->request->parameters
    );

    if ($form->validated) {
        $flight->set_enable();

        eval { $flight->create(); };
        $form->process_error($@) if $@;
    }

    $c->stash(
        form     => $form,
        template => $self->template_form,
    );
};

sub edit :Chained('id') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;

    $self->setup_stash_from_data($c);

    my $flight = $c->model($self->model)->new();
    my $form = $self->form($flight);
    $form->process(
        init_object => {
            CountryOfDeparture  => $self->get_object($c)->departure_airport->city->country_id,
            CityOfDeparture     => $self->get_object($c)->departure_airport->city_id,
            AirportOfDeparture  => $self->get_object($c)->departure_airport_id,
            CountryOfArrival    => $self->get_object($c)->destination_airport->city->country_id,
            CityOfArrival       => $self->get_object($c)->destination_airport->city_id,
            AirportOfArrival    => $self->get_object($c)->destination_airport_id,
            airline_id          => $self->get_object($c)->airline_id,
            code                => $self->get_object($c)->code,
        },
        params => $c->request->parameters
    );

    if ($form->validated) {
        eval {
            $flight->id( $self->get_object($c)->id );
            $flight->is_published( $self->get_object($c)->is_published );

            $flight->update();
        };

        $form->process_error($@) if $@;
    }

    $c->stash(
        form     => $form,
        template => $self->template_form
    );
};

sub enable :Chained('id') :PathPart('enable') :Args(0) {
    my ($self, $c) = @_;

    $self->get_object($c)->update({ is_published => ENABLE });

    $self->setup_stash_from_data($c);
    $self->setup_request_from_stash($c);
    $c->detach('default');
};

sub disable :Chained('id') :PathPart('disable') :Args(0) {
    my ($self, $c) = @_;

    $self->get_object($c)->update({ is_published => DISABLE });

    $self->setup_stash_from_data($c);
    $self->setup_request_from_stash($c);

    $c->detach('default');
};

sub delete :Chained('id') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;

    $self->setup_stash_from_data($c);
    $self->setup_request_from_stash($c);

    eval { $c->model($self->model)->delete( $self->get_object($c)->id ); };
    $self->show_message(context => $c, error => $@);

    $c->detach('default');
};

sub setup_stash_from_data :Private {
    my ($self, $c) = @_;

    my $flight = $self->get_object($c);
    $c->stash({
        CountryOfDeparture => $flight->departure_airport->city->country_id,
        CityOfDeparture    => $flight->departure_airport->city_id,
        AirportOfDeparture => $flight->departure_airport_id,
        CountryOfArrival   => $flight->destination_airport->city->country_id,
        CityOfArrival      => $flight->destination_airport->city_id,
        AirportOfArrival   => $flight->destination_airport_id,
    });
};

sub setup_request_from_stash :Private {
    my ($self, $c) = @_;

    my @param = qw(CountryOfDeparture CityOfDeparture AirportOfDeparture
                   CountryOfArrival   CityOfArrival   AirportOfArrival);
    $c->request->param($_, $c->stash->{$_})
        foreach (@param);
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

1;
