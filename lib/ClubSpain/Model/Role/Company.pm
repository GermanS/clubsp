package ClubSpain::Model::Role::Company;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose::Role;

requires qw(
    zipcode
    street
    company
    nick
    website
    INN
    OKPO
    OKVED
    is_NDS
    validate_zipcode
    validate_street
    validate_company
    validate_nick
    validate_website
    validate_INN
    validate_OKPO
    validate_OKVED
    validate_is_NDS
);

sub notify {
    my ($self, $object) = @_;

    $self->zipcode($object->zipcode);
    $self->street($object->street);
    $self->company($object->company);
    $self->nick($object->nick);
    $self->website($object->website);
    $self->INN($object->INN);
    $self->OKPO($object->OKPO);
    $self->OKVED($object->OKVED);
    $self->is_NDS($object->is_NDS);
}

1;
