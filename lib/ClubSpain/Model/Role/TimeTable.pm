package ClubSpain::Model::Role::TimeTable;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose::Role;

requires qw(
    get_flight_id
    set_flight_id
    validate_flight_id
    get_airplane_id
    set_airplane_id
    validate_airplane_id
    set_departure_date
    get_departure_date
    validate_departure_date
    set_departure_time
    get_departure_time
    validate_departure_time
    get_arrival_date
    set_arrival_date
    validate_arrival_date
    set_arrival_time
    get_arrival_time
    validate_arrival_time
);

sub notify {
    my ($self, $object) = @_;
    $self->set_flight_id($object->get_flight_id);
    $self->set_airplane_id($object->get_airplane_id);
    $self->set_departure_date($object->get_departure_date);
    $self->set_departure_time($object->get_departure_time);
    $self->set_arrival_date($object->get_arrival_date);
    $self->set_arrival_time($object->get_arrival_time);
}

1;
