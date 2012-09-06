package ClubSpain::Model::Flight;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Flight' });

has 'id' => (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'airport_of_departure' => (
    is      => 'rw',
    reader  => 'get_airport_of_departure',
    writer  => 'set_airport_of_departure',
);
has 'airport_of_arrival' => (
    is      => 'rw',
    reader  => 'get_airport_of_arrival',
    writer  => 'set_airport_of_arrival',
);
has 'airline_id' => (
    is      => 'rw',
    reader  => 'get_airline_id',
    writer  => 'set_airline_id',
);
has 'code' => (
    is      => 'rw',
    isa     => 'NaturalLessThan10000',
    reader  => 'get_code',
    writer  => 'set_code',
);
has 'is_published' => (
    is      => 'rw',
    reader  => 'get_is_published',
    writer  => 'set_is_published',
);

with 'ClubSpain::Model::Role::Flight';

sub validate_airport_of_departure { 1; }
sub validate_airport_of_arrival   { 1; }
sub validate_airline_id           { 1; }
sub validate_code {
    my ($self, $value) = @_;
    $self->meta()->get_attribute('code')->type_constraint->validate($value);
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
        departure_airport_id    => $self->get_airport_of_departure,
        destination_airport_id  => $self->get_airport_of_arrival,
        airline_id              => $self->get_airline_id,
        code                    => $self->get_code,
        is_published            => $self->get_is_published,
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
