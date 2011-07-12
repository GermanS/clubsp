package ClubSpain::Model::Itinerary;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Itinerary' });

has 'id'            => ( is => 'ro' );
has 'is_published'  => ( is => 'ro', required => 1 );
has 'timetable_id'  => ( is => 'ro', required => 1 );
has 'fare_class_id' => ( is => 'ro', required => 1 );
has 'parent_id'     => ( is => 'ro', required => 1 );
has 'cost'          => ( is => 'ro', required => 1 );

sub create {
    my $self = shift;

    $self->SUPER::create({
        is_published  => $self->is_published,
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
        is_published  => $self->is_published,
        timetable_id  => $self->timetable_id,
        fare_class_id => $self->fare_class_id,
        parent_id     => $self->parent_id,
        cost          => $self->cost,
    });
}

# поиск тарифов по идентификаторам расписания
# timetable1, [timetable2]
sub searchItinerary {
    my ($self, @params) = @_;

    return
        $self->schema()
             ->resultset($self->source_name)
             ->searchItinerary(@params);
}

# поиск тарифов по городам вылета и прилета
# {cityOfDFeparture => , cityOfArrival => }, [{cityOfDFeparture => , cityOfArrival => }]
sub itineraries {
    my ($self, @params) = @_;

    return
        $self->schema()
             ->resultset($self->source_name)
             ->itineraries(@params);
}

=head2 searchDatesOfDeparture(%params)

Поиск дат отправление среди тарифов в одну сторону
из города отправления в город прибытия
На входе
    cityOfDeparture - город отправления
    cityOfarrival   - город прибытия
На выходе
    Даты отправления

=cut

sub searchDatesOfDepartureOW {
    my ($self, %params) = @_;

    return
        $self->schema()
             ->resultset('ViewItineraryOW')
             ->searchDatesOfDeparture(%params);
}

=head2 searchDatesOfDeparture1RT(%params)

Поиск дат отправления в первом сегменте тарифа в обе стороны
На входе
    cityOfDeparture1 - первый город отправления
    cityOfArrival1   - первый город прибытия
    cityOfDeparture2 - второй город отправления
    cityOfArrival2   - второй город прибытия

На выходе
    Даты отправления первого сегмента

=cut

sub searchDatesOfDeparture1RT {
    my ($self, %params) = @_;

    return
        $self->schema()
             ->resultset('ViewItineraryRT')
             ->searchDatesOfDeparture1RT(%params);
}

=searchDatesOfDeparture2RT(%params)

Поиск дат отправления во втором сегменте тарифа в обе стороны
На входе
    cityOfDeparture1 - первый город отправления
    cityOfArrival1   - первый город прибытия
    dateOfDeparture1 - дата отправления
    cityOfDeparture2 - второй город отправления
    cityOfArrival2   - второй город прибытия

На выходе
    Даты отправления второго сегмента

=cut

sub searchDatesOfDeparture2RT {
    my ($self, %params) = @_;

    return
        $self->schema()
             ->resultset('ViewItineraryRT')
             ->searchDatesOfDeparture2RT(%params);
}

__PACKAGE__->meta->make_immutable;

1;
