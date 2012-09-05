package ClubSpain::Model::Role::City;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose::Role;

requires qw(
    get_country_id  set_country_id  validate_country_id
    get_iata        set_iata        validate_iata
    get_name_en     set_name_en     validate_name_en
    get_name_ru     set_name_ru     validate_name_ru
);

sub notify {
    my ($self, $object) = @_;
    $self->set_country_id($object->get_country_id);
    $self->set_iata($object->get_iata);
    $self->set_name_ru($object->get_name_ru);
    $self->set_name_en($object->get_name_en);
}

1;
