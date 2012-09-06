package ClubSpain::Model::Role::Employee;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose::Role;

requires qw(
    get_name    set_name    validate_name
    get_surname set_surname validate_surname
    get_email   set_email   validate_email
    get_password set_password validate_password
);

sub notify {
    my ($self, $object) = @_;
    $self->set_name(
        $object->get_name
    );
    $self->set_surname(
        $object->get_surname
    );
    $self->set_email(
        $object->get_email
    );
    $self->set_password(
        $object->get_password
    );
}

1;
