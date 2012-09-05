package ClubSpain::Model::Role::Country;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose::Role;

requires qw(
    get_name        set_name        validate_name
    get_alpha2      set_alpha2      validate_alpha2
    get_alpha3      get_alpha3      validate_alpha3
    get_numerics    set_numerics    validate_numerics
);

sub notify {
    my ($self, $object) = @_;
    $self->set_name($object->get_name);
    $self->set_alpha2($object->get_alpha2);
    $self->set_alpha3($object->get_alpha3);
    $self->set_numerics($object->get_numerics);
}

1;
