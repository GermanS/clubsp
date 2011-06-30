package ClubSpain::Model::City;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'City' });

has 'id'            => ( is => 'ro' );
has 'country_id'    => ( is => 'ro', required => 1 );
has 'iata'          => ( is => 'ro', required => 1, isa => 'AlphaNumericLength3' );
has 'name'          => ( is => 'ro', required => 1, isa => 'StringLength2to255' );
has 'is_published'  => ( is => 'ro', required => 1 );

sub create {
    my $self = shift;

    $self->SUPER::create({
        country_id   => $self->country_id,
        iata         => $self->iata,
        name         => $self->name,
        is_published => $self->is_published,
    });
}

sub update {
    my $self = shift;

    $self->check_for_class_method();

    $self->SUPER::update({
        country_id   => $self->country_id,
        iata         => $self->iata,
        name         => $self->name,
        is_published => $self->is_published,
    });
}

sub searchCitiesOfDeparture {
    my ($self, %params) = @_;

    return
        $self->schema()
             ->resultset($self->source_name)
             ->searchCitiesOfDeparture(%params);
}

sub searchCitiesOfDepartureInFlight {
    my $self = shift;

    return
        $self->schema()
             ->resultset('ViewFlight')
             ->searchCitiesOfDeparture();
}

sub searchCitiesOfArrivalInFlight {
    my ($self, %params) = @_;

    return
        $self->schema()
             ->resultset('ViewFlight')
             ->searchCitiesOfArrival(%params);
}

sub searchCitiesOfDepartureInTimeTable {
    my $self = shift;

    return
        $self->schema()
             ->resultset('ViewTimeTable')
             ->searchCitiesOfDeparture();
}

sub searchCitiesOfArrivalInTimeTable {
    my ($self, %params) = @_;

    return
        $self->schema()
             ->resultset('ViewTimeTable')
             ->searchCitiesOfArrival(%params);
}

sub searchCitiesOfDepartureInOWItinerary {
    my $self = shift;

    return
        $self->schema()
             ->resultset($self->source_name)
             ->searchCitiesOfDepartureInOWItinerary();
}

sub searchCitiesOfArrivalInOWItinerary {
    my ($self, %params) = @_;

    return
        $self->schema()
             ->resultset($self->source_name)
             ->searchCitiesOfArrivalInOWItinerary(%params);
}

sub searchCitiesOfDeparture1InRTItinerary {
    my $self = shift;

    return
        $self->schema()
             ->resultset($self->source_name)
             ->searchCitiesOfDeparture1InRTItinerary();
}

__PACKAGE__->meta->make_immutable();

1;
