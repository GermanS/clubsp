package ClubSpain::Model::TerminalRole;
use strict;
use warnings;
use Moose::Role;

sub validate_name {
    my ($self, $value) = @_;

    $self->meta()->get_attribute('name')->type_constraint->validate($value);
}

1;
