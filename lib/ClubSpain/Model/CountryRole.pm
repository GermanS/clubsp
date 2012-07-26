package ClubSpain::Model::CountryRole;
use strict;
use warnings;
use Moose::Role;

sub validate_name {
    my ($self, $value) = @_;

    $self->meta()->get_attribute('name')->type_constraint->validate($value);
}

sub validate_alpha2 {
    my ($self, $value) = @_;

    $self->meta()->get_attribute('alpha2')->type_constraint->validate($value);
}

sub validate_alpha3 {
    my ($self, $value) = @_;

    $self->meta()->get_attribute('alpha3')->type_constraint->validate($value);
}

sub validate_numerics {
    my ($self, $value) = @_;

    $self->meta()->get_attribute('numerics')->type_constraint->validate($value);
}

1;
