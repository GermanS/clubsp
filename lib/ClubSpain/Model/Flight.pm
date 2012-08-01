package ClubSpain::Model::Flight;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);

use ClubSpain::Types;
    with 'ClubSpain::Model::FlightRole';

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Flight' });

has 'id'                     => ( is => 'rw' );
has 'is_published'           => ( is => 'rw', required => 0 );
has 'departure_airport_id'   => ( is => 'rw', required => 0 );
has 'destination_airport_id' => ( is => 'rw', required => 0 );
has 'airline_id'             => ( is => 'rw', required => 0 );
has 'code'                   => ( is => 'rw', required => 0,  isa => 'NaturalLessThan10000' );

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
        is_published            => $self->is_published,
        departure_airport_id    => $self->departure_airport_id,
        destination_airport_id  => $self->destination_airport_id,
        airline_id              => $self->airline_id,
        code                    => $self->code,
    };
}

sub searchFlights {
    my ($self, %params) = @_;

    return
        $self->schema()
             ->resultset($self->source_name)
             ->searchFlights(%params);
}

sub searchFlightsInTimetable {
    my ($self, %params) = @_;

    return
        $self->schema()
             ->resultset($self->source_name)
             ->searchFlightsInTimetable(%params);
}

__PACKAGE__->meta->make_immutable();

1;
