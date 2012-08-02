package ClubSpain::Form::BackOffice::TimeTableRole;
use strict;
use warnings;
use Moose::Role;
use namespace::autoclean;

sub validate_DateOfDeparture {
    my ($self, $field) = @_;

    eval { $self->model_object->validate_departure_date($field->value); };
    if ($@) {
        $self->process_validation_error($field);
    }
}

sub validate_TimeOfDeparture {
    my ($self, $field) = @_;

    eval { $self->model_object->validate_departure_time($field->value) };
    if ($@) {
        $self->process_validation_error($field);
    }
}

sub validate_DateOfArrival {
    my ($self, $field) = @_;

    eval { $self->model_object->validate_arrival_date($field->value) };
    if ($@) {
        $self->process_validation_error($field);
    }
}

sub validate_TimeOfArrival {
    my ($self, $field) = @_;

    eval { $self->model_object->validate_arrival_time($field->value) };
    if ($@) {
        $self->process_validation_error($field);
    }
}

1;
