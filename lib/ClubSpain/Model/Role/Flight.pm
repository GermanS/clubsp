package ClubSpain::Model::Role::Flight;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose::Role;

requires qw(
    get_airport_of_departure
    set_airport_of_departure
    validate_airport_of_departure
    get_airport_of_arrival
    set_airport_of_arrival
    validate_airport_of_arrival
    get_airline_id
    set_airline_id
    validate_airline_id
    get_code
    set_code
    validate_code
);

sub notify {
    my ($self, $object) = @_;

    $self->set_airport_of_departure(
        $object->get_airport_of_departure
    );
    $self->set_airport_of_arrival(
        $object->get_airport_of_arrival
    );
    $self->set_airline_id(
        $object->get_airline_id
    );
    $self->set_code(
        $object->get_code
    );
}

1;
