package ClubSpain::Model::Role::Country;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose::Role;

requires qw(
    country
    alpha2
    alpha3
    numerics
    validate_country
    validate_alpha2
    validate_alpha3
    validate_numerics
);

sub notify {
    my ($self, $object) = @_;

    $self->country($object->country);
    $self->alpha2($object->alpha2);
    $self->alpha3($object->alpha3);
    $self->numerics($object->numerics);
}

1;
