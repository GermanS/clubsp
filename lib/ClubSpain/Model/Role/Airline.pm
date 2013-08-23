package ClubSpain::Model::Role::Airline;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose::Role;

requires qw(
    get_iata
    set_iata
    get_icao
    set_icao
    get_name
    set_name
);

sub notify {
    my ($self, $object) = @_;

    $self -> set_iata( $object -> get_iata() );
    $self -> set_icao( $object -> get_icao() );
    $self -> set_name( $object -> get_name() );

    return;
}

sub validate_iata {
    my ($self, $value) = @_;
    $self -> meta() -> get_attribute('iata') -> type_constraint() -> validate( $value );
}

sub validate_icao {
    my ($self, $value) = @_;
    $self -> meta() -> get_attribute('icao') -> type_constraint() -> validate( $value );
}

sub validate_name {
    my ($self, $value) = @_;
    $self -> meta() -> get_attribute('name') -> type_constraint() -> validate( $value );
}

sub params {
    my $self = shift;

    return {
        iata         => $self -> get_iata(),
        icao         => $self -> get_icao(),
        name         => $self -> get_name(),
        is_published => $self -> get_is_published(),
    };
}

1;

__END__

=pod

=head1 NAME

ClubSpain::Model::Role::Airline

=head1 DESCRIPTION

Интерфиейс для работы с авиакомпанией

=head1 METHODS

=head2 validate_name()

Проверка названия авиакомпании

=head2 validate_icao()

Проверка ICAO кода авиакомпании

=head2 validate_iata()

Проверка IATA кода авиакомпании

=head1 SEE ALSO

=head2 notify()

#TODO: описать метод

L<Moose::Role>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut