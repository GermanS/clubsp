package ClubSpain::Model::Role::Airline;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose::Role;

requires qw(
    airline
    iata
    icao
    validate_airline
    validate_iata
    validate_icao
);

sub notify {
    my ($self, $object) = @_;

    $self->airline($object->airline);
    $self->iata($object->iata);
    $self->icao($object->icao);
}

1;
