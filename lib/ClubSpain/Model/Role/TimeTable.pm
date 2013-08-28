package ClubSpain::Model::Role::TimeTable;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose::Role;

requires qw(
    set_flight_id       get_flight_id
    set_airplane_id     get_airplane_id
    set_departure_date  get_departure_date
    set_departure_time  get_departure_time
    set_arrival_date    get_arrival_date
    set_arrival_time    get_arrival_time
);

sub validate_flight_id   {
    my ($self, $value) = @_;
    return 1;
}

sub validate_airplane_id {
    my ($self, $value) = @_;
    return 1;
}

sub validate_departure_date {
    my ($self, $value) = @_;
    return 1;
}

sub validate_departure_time {
    my ($self, $value) = @_;
    return 1;
}

sub validate_arrival_date {
    my ($self, $value) = @_;
    return 1;
}

sub validate_arrival_time {
    my ($self, $value) = @_;
    return 1;
}

sub notify {
    my ($self, $object) = @_;

    $self -> set_flight_id( $object -> get_flight_id() );
    $self -> set_airplane_id( $object -> get_airplane_id() );
    $self -> set_departure_date( $object -> get_departure_date() );
    $self -> set_departure_time( $object -> get_departure_time() );
    $self -> set_arrival_date( $object -> get_arrival_date() );
    $self -> set_arrival_time( $object -> get_arrival_time() );

    return;
}

sub params {
    my $self = shift;

    return {
        is_published    => $self -> get_is_published(),
        is_free         => $self -> get_is_free(),
        flight_id       => $self -> get_flight_id(),
        departure_date  => $self -> get_departure_date(),
        departure_time  => $self -> get_departure_time(),
        arrival_date    => $self -> get_arrival_date(),
        arrival_time    => $self -> get_arrival_time(),
        airplane_id     => $self -> get_airplane_id(),
    };
}


1;

__END__

=pod

=head1 NAME

ClubSpain::Model::Role::TimeTable

=head1 DESCRIPTION

Интерфейсные методы расписания

=head1 METHODS

=head2 validate_flight_id()

Проверка идентификатора маршрута

=head2 validate_airplane_id()

Проверка идентификатора марки самолета

=head2 validate_departure_date()

Проверка даты отправления

=head2 validate_departure_time()

Проверка времени отправления

=head2 validate_arrival_date()

Проверка даты прибытия

=head2 validate_arrival_time()

Проверка времени прибытия

=head2 notify()

#TODO: notify()

=head2 params()

#TODO: params()

=head1 SEE ALSO

L<Moose::Role>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut