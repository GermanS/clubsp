package ClubSpain::Model::Airport;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Airport' });

has 'id'            => ( is => 'rw' );
has 'city_id'       => ( is => 'rw', required => 0 );
has 'iata'          => ( is => 'rw', required => 0, isa => 'AlphaLength3' );
has 'icao'          => ( is => 'rw', required => 0, isa => 'AlphaLength4' );
has 'airport'       => ( is => 'rw', required => 0, isa => 'StringLength2to255' );
has 'is_published'  => ( is => 'rw', required => 0 );

with 'ClubSpain::Model::Role::Airport';

sub validate_airport {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('airport')->type_constraint->validate($value);
}
sub validate_iata {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('iata')->type_constraint->validate($value);
}
sub validate_icao {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('icao')->type_constraint->validate($value);
}

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
        name         => $self->airport,
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
