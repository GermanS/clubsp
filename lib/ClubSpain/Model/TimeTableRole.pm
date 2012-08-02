package ClubSpain::Model::TimeTableRole;
use strict;
use warnings;
use Moose::Role;

sub validate_departure_date {
    my ($self, $value) = @_;

    $self->meta()->get_attribute('departure_date')->type_constraint->validate($value);
}

sub validate_departure_time {
    my ($self, $value) = @_;

    $self->meta()->get_attribute('departure_time')->type_constraint->validate($value);
}

sub validate_arrival_date {
    my ($self, $value) = @_;

    $self->meta()->get_attribute('arrival_date')->type_constraint->validate($value);
}

sub validate_arrival_time {
    my ($self, $value) = @_;

    $self->meta()->get_attribute('arrival_time')->type_constraint->validate($value);
}


1;
