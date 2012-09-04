package ClubSpain::Model::Role::Employee;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose::Role;

requires qw(
    first_name
    surname
    email
    password
    validate_first_name
    validate_surname
    validate_email
    validate_password
);

sub notify {
    my ($self, $object) = @_;

    $self->first_name($object->first_name);
    $self->surname($object->surname);
    $self->email($object->email);
    $self->password($object->password);
}

1;
