package ClubSpain::Model::Role::Airport;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose::Role;

requires qw(
    get_city_id set_city_id validate_city_id
    get_name    set_name    validate_name
    get_iata    set_iata    validate_iata
    get_icao    set_icao    validate_icao
);

sub notify {
    my ($self, $object) = @_;
    $self->set_city_id($object->get_city_id);
    $self->set_name($object->get_name);
    $self->set_iata($object->get_iata);
    $self->set_icao($object->get_icao);
}

1;
