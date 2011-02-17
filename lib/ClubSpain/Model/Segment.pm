package ClubSpain::Model::Segment;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Segment' });

has 'fare_class_id' => ( is => 'ro', required => 1 );
has 'fare_id'       => ( is => 'ro', required => 1 );
has 'timetable_id'  => ( is => 'ro', required => 1 );


sub create {
    my $self = shift;

    $self->SUPER::create({
        fare_class_id => $self->fare_class_id,
        fare_id       => $self->fare_id,
        timetable_id  => $self->timetable_id,
    });
}

sub update {
    my $self = shift;

    $self->check_for_class_method();

    $self->SUPER::update({
        fare_class_id => $self->fare_class_id,
        fare_id       => $self->fare_id,
        timetable_id  => $self->timetable_id,
    });
}

1;
