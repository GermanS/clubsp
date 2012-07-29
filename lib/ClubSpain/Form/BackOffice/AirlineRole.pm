package ClubSpain::Form::BackOffice::AirlineRole;
use strict;
use warnings;
use Moose::Role;
use namespace::autoclean;
use ClubSpain::Exception;

sub validate_name {
    my ($self, $field) = @_;

    eval { $self->airline->validate_name($field->value); };
    if ($@) {
        $self->process_validation_error($field);
    }
}

sub validate_iata {
    my ($self, $field) = @_;

    eval { $self->airline->validate_iata($field->value) };
    if ($@) {
        $self->process_validation_error($field);
    }
}

sub validate_icao {
    my ($self, $field) = @_;

    eval { $self->airline->validate_icao($field->value) };
    if ($@) {
        $self->process_validation_error($field);
    }
}

1;
