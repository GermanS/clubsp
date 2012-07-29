package ClubSpain::Model::AirlineRole;
use strict;
use warnings;
use Moose::Role;

sub validate_name {
    my ($self, $value) = @_;

    $self->meta()->get_attribute('name')->type_constraint->validate($value);
}

sub validate_iata {
    my ($self, $value) = @_;

    $self->meta()->get_attribute('iata')->type_constraint->validate($value);
}

sub validate_icao {
    my ($self, $value) = @_;

    $self->meta()->get_attribute('icao')->type_constraint->validate($value);
}

1;
