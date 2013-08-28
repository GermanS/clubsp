package ClubSpain::Model::Role::Terminal;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose::Role;

requires qw(
    get_name        set_name
    get_airport_id  set_airport_id
);

sub validate_airport_id {
    return 1;
}

sub validate_name {
    my ($self, $value) = @_;

    return $self -> meta() -> get_attribute('name') -> type_constraint -> validate($value);
}

sub notify {
    my ($self, $object) = @_;

    $self -> set_name( $object -> get_name() );
    $self -> set_airport_id( $object -> get_airport_id() );

    return;
}

sub params {
    my $self = shift;

    return {
        airport_id   => $self -> get_airport_id(),
        name         => $self -> get_name(),
        is_published => $self -> get_is_published(),
    };
}

1;

__END__

=pod

=head1 NAME

ClubSpain::Model::Role::Terminal

=head1 DESCRIPTION

Интерфейсные методы для терминала аэропорта

=head1 METHODS

=head2 validate_name()

Проверка названия терминала

=head2 validate_airport_id()

Проверка аэропорта

=head2 notify()

#TODO: документация notify()

=head2 params()

#TODO: документация params()
=head1 SEE ALSO

L<Moose::Role>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut