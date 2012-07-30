package ClubSpain::Form::BackOffice::TerminalRole;
use strict;
use warnings;
use Moose::Role;
use namespace::autoclean;

sub validate_name {
    my ($self, $field) = @_;

    eval { $self->model_object->validate_name($field->value); };
    if ($@) {
        $self->process_validation_error($field);
    }
}

1;
