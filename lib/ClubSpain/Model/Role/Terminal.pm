package ClubSpain::Model::Role::Terminal;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose::Role;

requires qw(
    get_name
    set_name
    validate_name
    get_airport_id
    set_airport_id
    validate_airport_id
);

sub notify {
    my ($self, $object) = @_;
    $self->set_name($object->get_name);
    $self->set_airport_id($object->get_airport_id);
}

1;
