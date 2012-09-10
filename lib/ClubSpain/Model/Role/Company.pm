package ClubSpain::Model::Role::Company;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose::Role;

requires qw(
    get_zipcode set_zipcode validate_zipcode
    get_street  set_street  validate_street
    get_name    set_name    validate_name
    get_nick    set_nick    validate_nick
    get_website set_website validate_website
    get_INN     set_INN     validate_INN
    get_OKPO    set_OKPO    validate_OKPO
    get_OKVED   set_OKVED   validate_OKVED
    get_is_NDS  set_is_NDS  validate_is_NDS

);

sub notify {
    my ($self, $object) = @_;

    $self->set_zipcode($object->get_zipcode);
    $self->set_street($object->get_street);
    $self->set_name($object->get_name);
    $self->set_nick($object->get_nick);
    $self->set_website($object->get_website);
    $self->set_INN($object->get_INN);
    $self->set_OKPO($object->get_OKPO);
    $self->set_OKVED($object->get_OKVED);
    $self->set_is_NDS($object->get_is_NDS);
}

1;
