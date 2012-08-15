package ClubSpain::Form::BackOffice::CityRole;
use strict;
use warnings;
use Moose::Role;
use utf8;
use namespace::autoclean;

sub validate_name {
    my ($self, $field) = @_;

    eval { $self->model_object->validate_name($field->value); };
    if ($@) {
        $self->process_validation_error($field);
    }
}

sub validate_name_ru {
    my ($self, $field) = @_;

    eval { $self->model_object->validate_name_ru($field->value) };
    if ($@) {
        $self->process_validation_error($field);
    }
}

sub validate_iata {
    my ($self, $field) = @_;

    eval { $self->model_object->validate_iata($field->value) };
    if ($@) {
        $self->process_validation_error($field);
    }
}

1;
