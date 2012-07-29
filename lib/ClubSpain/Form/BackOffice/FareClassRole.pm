package ClubSpain::Form::BackOffice::FareClassRole;
use strict;
use warnings;
use Moose::Role;
use namespace::autoclean;

sub validate_name {
    my ($self, $field) = @_;

    eval { $self->fareclass->validate_name($field->value); };
    if ($@) {
        $self->process_validation_error($field);
    }
}

sub validate_code {
    my ($self, $field) = @_;

    eval { $self->fareclass->validate_code($field->value) };
    if ($@) {
        $self->process_validation_error($field);
    }
}

1;
