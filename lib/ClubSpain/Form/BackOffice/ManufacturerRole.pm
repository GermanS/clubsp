package ClubSpain::Form::BackOffice::ManufacturerRole;
use strict;
use warnings;
use Moose::Role;
use namespace::autoclean;

sub validate_name {
    my ($self, $field) = @_;

    eval { $self->manufacturer->validate_name($field->value); };
    if ($@) {
        $self->process_validation_error($field);
    }
}

sub validate_code {
    my ($self, $field) = @_;

    eval { $self->manufacturer->validate_code($field->value) };
    if ($@) {
        $self->process_validation_error($field);
    }
}

1;
