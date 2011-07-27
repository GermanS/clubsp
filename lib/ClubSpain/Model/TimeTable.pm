package ClubSpain::Model::TimeTable;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'TimeTable' });

has 'id'                    => ( is => 'ro' );
has 'is_published'          => ( is => 'ro', required => 1 );
has 'flight_id'             => ( is => 'ro', required => 1 );
has 'departure_date'        => ( is => 'ro', required => 1 );
has 'departure_time'        => ( is => 'ro', required => 1 );
has 'arrival_date'          => ( is => 'ro', required => 1 );
has 'arrival_time'          => ( is => 'ro', required => 1 );
has 'airplane_id'           => ( is => 'ro' );
has 'departure_terminal_id' => ( is => 'ro' );
has 'arrival_terminal_id'   => ( is => 'ro' );

sub create {
    my $self = shift;

    $self->SUPER::create({
        is_published    => $self->is_published,
        flight_id       => $self->flight_id,
        departure_date  => $self->departure_date,
        departure_time  => $self->departure_time,
        arrival_date    => $self->arrival_date,
        arrival_time    => $self->arrival_time,
        airplane_id     => $self->airplane_id,
        departure_terminal_id   => $self->departure_terminal_id,
        arrival_terminal_id     => $self->arrival_terminal_id,
    });
}

sub update {
    my $self = shift;

    $self->check_for_class_method();

    return $self->SUPER::update({
        is_published    => $self->is_published,
        flight_id       => $self->flight_id,
        departure_date  => $self->departure_date,
        departure_time  => $self->departure_time,
        arrival_date    => $self->arrival_date,
        arrival_time    => $self->arrival_time,
        airplane_id     => $self->airplane_id,
        departure_terminal_id   => $self->departure_terminal_id,
        arrival_terminal_id     => $self->arrival_terminal_id,
    });
}

sub searchDatesOfDeparture {
    my ($self, %params) = @_;

    return
        $self->schema()
             ->resultset($self->source_name)
             ->searchDatesOfDeparture(%params);
}

sub searchTimetable {
    my ($self, %params) = @_;

    return
        $self->schema()
             ->resultset($self->source_name)
             ->searchTimetable(%params);
}

sub departures {
    my ($self, %params) = @_;

    return
        $self->schema()
             ->resultset($self->source_name)
             ->departures(%params);
}

sub arrivals {
    my ($self, %params) = @_;

    return
        $self->schema()
             ->resultset($self->source_name)
             ->arrivals(%params);
}

__PACKAGE__->meta->make_immutable;

1;
