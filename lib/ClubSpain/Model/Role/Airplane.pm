package ClubSpain::Model::Role::Airplane;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose::Role;

requires qw(
    airplane
    iata
    icao
    validate_airplane
    validate_iata
    validate_icao
);

sub notify {
    my ($self, $object) = @_;

    $self->manufacturer_id($object->manufacturer_id);
    $self->airplane($object->airplane);
    $self->iata($object->iata);
    $self->icao($object->icao);
}

1;
