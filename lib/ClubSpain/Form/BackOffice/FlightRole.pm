package ClubSpain::Form::BackOffice::FlightRole;
use strict;
use warnings;
use Moose::Role;
use namespace::autoclean;

sub validate_code {
    my ($self, $field) = @_;

    eval { $self->model_object->validate_code($field->value); };
    if ($@) {
        $self->process_validation_error($field);
    }
}

1;
