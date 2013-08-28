package ClubSpain::Model::Role::Flight;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose::Role;

requires qw(
    get_airport_of_departure    set_airport_of_departure
    get_airport_of_arrival      set_airport_of_arrival
    get_airline_id              set_airline_id
    get_code                    set_code
);

sub validate_airport_of_departure {
    return 1;
}

sub validate_airport_of_arrival {
    return 1;
}

sub validate_airline_id {
    return 1;
}

sub validate_code {
    my ($self, $value) = @_;

    return $self -> meta() -> get_attribute('code') -> type_constraint -> validate($value);
}


sub notify {
    my ($self, $object) = @_;

    $self -> set_airport_of_departure( $object -> get_airport_of_departure() );
    $self -> set_airport_of_arrival( $object -> get_airport_of_arrival() );
    $self -> set_airline_id( $object -> get_airline_id() );
    $self -> set_code( $object -> get_code() );

    return;
}

sub params {
    my $self = shift;

    return {
        departure_airport_id    => $self -> get_airport_of_departure(),
        destination_airport_id  => $self -> get_airport_of_arrival(),
        airline_id              => $self -> get_airline_id(),
        code                    => $self -> get_code(),
        is_published            => $self -> get_is_published(),
    };
}

1;

__END__

=pod

=head1 NAME

ClubSpain::M<odel::Role::Flight

=head1 DESCRIPTION

Интерфейсные методы для рейса

=head1 METHODS

=head2 validate_airport_of_departure()

Проверка идентфикатора аэропорта отправления

=head2 validate_airport_of_arrival()

Проверка идентификатора аэропорта прибытия

=head2 validate_airline_id()

Проверка идентификатора авиакомпании

=head2 validate_code()

Проверка кода рейса

=head2 notify()

#TODO: документация для notify()

=head2 params()

#TODO: документация для params()

=head1 SEE ALSO

L<ClubSpain::Model::Flight>
L<Moose::Role>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut