package ClubSpain::Model::Role::Airplane;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose::Role;

requires qw(
    get_name
    set_name
    validate_name
    get_iata
    set_iata
    validate_iata
    get_icao
    set_icao
    validate_icao
    get_manufacturer_id
    set_manufacturer_id
    validate_manufacturer_id
);

sub notify {
    my ($self, $object) = @_;
    $self->set_manufacturer_id($object->get_manufacturer_id);
    $self->set_name($object->get_name);
    $self->set_iata($object->get_iata);
    $self->set_icao($object->get_icao);
}

1;
