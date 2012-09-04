package ClubSpain::Model::Role::City;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose::Role;

requires qw(
    country_id
    iata
    name_en
    name_ru
    validate_country_id
    validate_iata
    validate_name_en
    validate_name_ru
);

sub notify {
    my ($self, $object) = @_;

    $self->country_id($object->country_id);
    $self->iata($object->iata);
    $self->name_ru($object->name_ru);
    $self->name_en($object->name_en);
}

1;
