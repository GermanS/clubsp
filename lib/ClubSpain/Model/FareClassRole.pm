package ClubSpain::Model::FareClassRole;
use strict;
use warnings;
use Moose::Role;

sub validate_name {
    my ($self, $value) = @_;

    $self->meta()->get_attribute('name')->type_constraint->validate($value);
}

sub validate_code {
    my ($self, $value) = @_;

    $self->meta()->get_attribute('code')->type_constraint->validate($value);
}

1;
