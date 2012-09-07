package ClubSpain::Model::Role::Itinerary;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose::Role;

requires qw(
    get_timetable_id
    set_timetable_id
    validate_timetable_id
    get_fare_class_id
    set_fare_class_id
    validate_fare_class_id
    set_cost
    get_cost
    validate_cost
);

sub notify {
    my ($self, $object) = @_;
    $self->set_timetable_id($object->get_timetable_id);
    $self->set_fare_class_id($object->get_fare_class_id);
    $self->set_return_segment($object->get_return_segment);
    $self->set_cost($object->get_cost);
}

1;
