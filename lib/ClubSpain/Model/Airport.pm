package ClubSpain::Model::Airport;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Airport' });

has 'id'            => ( is => 'ro' );
has 'city_id'       => ( is => 'ro', required => 1 );
has 'iata'          => ( is => 'ro', required => 1, isa => 'AlphaLength3' );
has 'icao'          => ( is => 'ro', required => 1, isa => 'AlphaLength4' );
has 'name'          => ( is => 'ro', required => 1, isa => 'StringLength2to255' );
has 'is_published'  => ( is => 'ro', required => 1 );

sub create {
    my $self = shift;

    $self->SUPER::create( $self->params() );
}

sub update {
    my $self = shift;

    $self->check_for_class_method();
    $self->SUPER::update( $self->params() );
}

sub params {
    my $self = shift;

    return {
        city_id      => $self->city_id,
        iata         => $self->iata,
        icao         => $self->icao,
        name         => $self->name,
        is_published => $self->is_published,
    };
}

sub searchAirportsOfDeparture {
    my ($self, %params) = @_;

    return
        $self->schema()
             ->resultset($self->source_name)
             ->searchAirportsOfDeparture(%params);
}

__PACKAGE__->meta->make_immutable();

1;
