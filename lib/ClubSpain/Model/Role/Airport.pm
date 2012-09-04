package ClubSpain::Model::Role::Airport;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose::Role;

requires qw(
    city_id
    airport
    iata
    icao
    validate_airport
    validate_iata
    validate_icao
);

sub notify {
    my ($self, $object) = @_;

    $self->city_id($object->city_id);
    $self->airport($object->airport);
    $self->iata($object->iata);
    $self->icao($object->icao);
}

1;
