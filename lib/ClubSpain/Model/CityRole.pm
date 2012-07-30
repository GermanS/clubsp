package ClubSpain::Model::CityRole;
use strict;
use warnings;
use Moose::Role;

sub validate_name {
    my ($self, $value) = @_;

    $self->meta()->get_attribute('name')->type_constraint->validate($value);
}

sub validate_name_ru {
    my ($self, $value) = @_;

    $self->meta()->get_attribute('name_ru')->type_constraint->validate($value);
}

sub validate_iata {
    my ($self, $value) = @_;

    $self->meta()->get_attribute('iata')->type_constraint->validate($value);
}

1;
