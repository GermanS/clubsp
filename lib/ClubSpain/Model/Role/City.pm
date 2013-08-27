package ClubSpain::Model::Role::City;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose::Role;

requires qw(
    get_country_id  set_country_id
    get_iata        set_iata
    get_name_en     set_name_en
    get_name_ru     set_name_ru
);

sub notify {
    my ($self, $object) = @_;

    $self -> set_country_id( $object -> get_country_id() );
    $self -> set_iata( $object -> get_iata() );
    $self -> set_name_ru( $object -> get_name_ru() );
    $self -> set_name_en( $object -> get_name_en() );

    return;
}

sub validate_country_id {
    return 1;
}

sub validate_iata {
    my ($self, $value) = @_;

    return $self -> meta() -> get_attribute( 'iata' ) -> type_constraint() -> validate( $value );
}

sub validate_name_en {
    my ($self, $value) = @_;

    return $self -> meta() -> get_attribute( 'name_en' ) -> type_constraint() -> validate( $value );
}

sub validate_name_ru {
    my ($self, $value) = @_;

    return $self -> meta() -> get_attribute( 'name_ru' ) -> type_constraint() -> validate( $value );
}

sub params {
    my $self = shift;

    return {
        country_id   => $self -> get_country_id(),
        iata         => $self -> get_iata(),
        name         => $self -> get_name_en(),
        name_ru      => $self -> get_name_ru(),
        is_published => $self -> get_is_published(),
    };
}

1;

__END__

=head1 NAME

ClubSpain::Model::Role::City

=head1 DESCRIPTION

ИНтерфейсные методы города

=head1 METHODS

=head2 validate_country_id()

Проверка идентификатора страны

=head2 validate_iata()

Проверка IATA кода города

=head2 validate_name_ru()

Проверка названия города на русском

=head2 validate_name_en()

Проверка названия города на латинском

=head2 notify()

#TODO: описание метода

=head2 params()

#TODO: описание метода

=head1 SEE ALSO

L<Moose::Role>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut