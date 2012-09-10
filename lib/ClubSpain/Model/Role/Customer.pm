package ClubSpain::Model::Role::Customer;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose::Role;

requires qw(
    get_name
    set_name
    validate_name
    get_surname
    set_surname
    validate_surname
    get_email
    set_email
    validate_email
    get_passwd
    set_passwd
    validate_passwd
    get_mobile
    set_mobile
    validate_mobile
);

sub notify {
    my ($self, $object) = @_;
    $self->set_name($object->get_name);
    $self->set_surname($object->get_surname);
    $self->set_email($object->get_email);
    $self->set_passwd($object->get_passwd);
    $self->set_mobile($object->get_mobile);
}

1;
