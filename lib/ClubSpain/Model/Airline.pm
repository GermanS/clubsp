package ClubSpain::Model::Airline;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Airline' });

has 'id'            => ( is => 'rw' );
has 'iata'          => ( is => 'rw', required => 0, isa => 'AlphaNumericLength2' );
has 'icao'          => ( is => 'rw', required => 0, isa => 'AlphaLength3' );
has 'airline'       => ( is => 'rw', required => 0, isa => 'StringLength2to255' );
has 'is_published'  => ( is => 'rw', required => 0 );

with 'ClubSpain::Model::Role::Airline';

sub validate_iata {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('iata')->type_constraint->validate($value);
}
sub validate_icao {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('icao')->type_constraint->validate($value);
}
sub validate_airline {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('airline')->type_constraint->validate($value);
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
        iata         => $self->iata,
        icao         => $self->icao,
        name         => $self->airline,
        is_published => $self->is_published,
    };
}

__PACKAGE__->meta->make_immutable;

1;
