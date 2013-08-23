package ClubSpain::Model::Role::Airport;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose::Role;

requires qw(
    get_city_id set_city_id
    get_name    set_name
    get_iata    set_iata
    get_icao    set_icao
);

sub notify {
    my ($self, $object) = @_;

    $self -> set_city_id( $object -> get_city_id() );
    $self -> set_name( $object -> get_name() );
    $self -> set_iata( $object -> get_iata() );
    $self -> set_icao( $object -> get_icao() );

    return;
}

sub validate_city_id {
}

sub validate_name {
    my ($self, $value) = @_;

    return
        $self -> meta() -> get_attribute('name') -> type_constraint() -> validate( $value );
}

sub validate_iata {
    my ($self, $value) = @_;

    return
        $self -> meta() -> get_attribute('iata') -> type_constraint() -> validate( $value );
}

sub validate_icao {
    my ($self, $value) = @_;

    return
        $self -> meta() -> get_attribute('icao') -> type_constraint() -> validate( $value );
}

sub params {
    my $self = shift;

    return {
        iata         => $self -> get_iata(),
        icao         => $self -> get_icao(),
        name         => $self -> get_name(),
        city_id      => $self -> get_city_id(),
        is_published => $self -> get_is_published(),
    };
}

1;

__END__

=pod

=head1 NAME

ClubSpain::Model::Role::Airport

=head1 DESCTIPTION

Интерфейс для аэропорта

=head1 METHODS

=head2 validate_city_id()

Проверка идентификатора города

=head2 validate_name()

Проверкам названия аэропорта

=head2 validate_icao()

Проверка ICAO кода аэропорта

=head2 validate_iata()

Проверка IATA кода аэропорта

=head2 params()

#TODO: документация для params()

=head1 SEE ALSO

L<Moose::Role>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut