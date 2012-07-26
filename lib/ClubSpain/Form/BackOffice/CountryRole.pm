package ClubSpain::Form::BackOffice::CountryRole;
use strict;
use warnings;
use Moose::Role;
use namespace::autoclean;
use ClubSpain::Exception;

sub validate_name {
    my ($self, $field) = @_;

    eval { $self->country->validate_name($field->value); };
    if ($@) {
        $self->process_validation_error($field);
    }
}

sub validate_alpha2 {
    my ($self, $field) = @_;

    eval { $self->country->validate_alpha2($field->value) };
    if ($@) {
        $self->process_validation_error($field);
    }
}

sub validate_alpha3 {
    my ($self, $field) = @_;

    eval { $self->country->validate_alpha3($field->value) };
    if ($@) {
        $self->process_validation_error($field);
    }
}

sub validate_numerics {
    my ($self, $field) = @_;

    eval { $self->country->validate_numerics($field->value) };
    if ($@) {
        $self->process_validation_error($field);
    }
}

sub process_validation_error {
    my ($self, $field) = @_;

    if (my $e = ClubSpain::Exception::Validation->caught()) {
        $field->add_error($e->message);
    } else {
        $field->add_error(ClubSpain::Exception::Base->new()->description);
    }
}

1;
