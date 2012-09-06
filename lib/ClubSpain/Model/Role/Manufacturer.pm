package ClubSpain::Model::Role::Manufacturer;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose::Role;

requires qw(
    get_name
    set_name
    get_code
    set_code
    validate_name
    validate_code
);

sub notify {
    my ($self, $object) = @_;
    $self->set_name($object->get_name);
    $self->set_code($object->get_code);
}

1;
