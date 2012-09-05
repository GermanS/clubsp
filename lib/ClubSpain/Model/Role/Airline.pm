package ClubSpain::Model::Role::Airline;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose::Role;

requires qw(
    get_iata
    set_iata
    get_icao
    set_icao
    get_name
    set_name
    validate_iata
    validate_icao
    validate_name
);

sub notify {
    my ($self, $object) = @_;
    $self->set_iata($object->get_iata);
    $self->set_icao($object->get_icao);
    $self->set_name($object->get_name);
}

1;
