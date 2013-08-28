package ClubSpain::Model::Role::FareClass;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose::Role;

requires qw(
    get_name    set_name
    get_code    set_code
);

sub validate_name {
    my ($self, $value) = @_;

    return $self -> meta() -> get_attribute('name') -> type_constraint -> validate($value);
}

sub validate_code {
    my ($self, $value) = @_;

    return $self -> meta() -> get_attribute('code') -> type_constraint -> validate($value);
}

sub notify {
    my ($self, $object) = @_;

    $self -> set_name( $object -> get_name() );
    $self -> set_code( $object -> get_code() );

    return;
}

sub params {
    my $self = shift;

    return {
        code         => $self -> get_code(),
        name         => $self -> get_name(),
        is_published => $self -> get_is_published(),
    };
}

1;

__END__

=pod

=head1 NAME

ClubSpain::Model::Role::FareClass;

=head1 DESCRIPTION

Интерфейсные методы класса обслуживания

=head1 METHODS

=head2 validate_code()

Проверка кода класса обслуживания

=head2 validate_name()

Проверка названия класса обслуживания

=head2 notify()

#TODO: документация к notify()

=head2 params()

#TODO: документация к params()

=head1 SEE ALSO

L<Moose::Role>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut