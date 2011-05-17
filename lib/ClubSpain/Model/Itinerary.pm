package ClubSpain::Model::Itinerary;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Itinerary' });

has 'id'            => ( is => 'ro' );
has 'timetable_id'  => ( is => 'ro', required => 1 );
has 'fare_class_id' => ( is => 'ro', required => 1 );
has 'parent_id'     => ( is => 'ro', required => 1 );
has 'cost'          => ( is => 'ro', required => 1 );



sub create {
    my $self = shift;

    $self->SUPER::create({
        timetable_id  => $self->timetable_id,
        fare_class_id => $self->fare_class_id,
        parent_id     => $self->parent_id,
        cost          => $self->cost,
    });
}

sub update {
    my $self = shift;

    $self->check_for_class_method();

    $self->SUPER::update({
        timetable_id  => $self->timetable_id,
        fare_class_id => $self->fare_class_id,
        parent_id     => $self->parent_id,
        cost          => $self->cost,
    });
}

sub searchItinerary {
    my ($self, @params) = @_;

    return
        $self->schema()
             ->resultset($self->source_name)
             ->searchItinerary(@params);
}

1;
