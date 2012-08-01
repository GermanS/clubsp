package ClubSpain::Model::FlightRole;
use strict;
use warnings;
use Moose::Role;

sub validate_code {
    my ($self, $value) = @_;

    $self->meta()->get_attribute('code')->type_constraint->validate($value);
}

1;
