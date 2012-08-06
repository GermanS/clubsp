package ClubSpain::Model::Itinerary;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;
use ClubSpain::Constants qw(:all);

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Itinerary' });

has 'id'             => ( is => 'rw' );
has 'is_published'   => ( is => 'rw' );
has 'timetable_id'   => ( is => 'rw' );
has 'return_segment' => ( is => 'rw' );
has 'fare_class_id'  => ( is => 'rw' );
has 'parent_id'      => ( is => 'rw', default => sub { 0 } );
has 'cost'           => ( is => 'rw' );

sub create {
    my $self = shift;

    $self->SUPER::create( $self->params() );
}

sub update {
    my $self = shift;

    $self->check_for_class_method();

    $self->SUPER::update( $self->params() );
}

sub insert_fare {
    my $self = shift;

    my $direct = $self->create();

    if ($self->return_segment) {
        my $return = $self->new({
            timetable_id  => $self->return_segment,
            fare_class_id => $self->fare_class_id,
            parent_id     => $direct->id,
            cost          => 0,
            is_published  => ENABLE,
        });

        $return->create();
    }

    return $direct;
}

sub update_fare {
    my $self = shift;

    my $direct = $self->update();
    my $return = $direct->next_route();
    if ($return) {
        $return->update({
            is_published  => $self->is_published,
            fare_class_id => $self->fare_class_id,
            cost          => 0
        });
    }

    return $direct;
}

sub delete_fare {
    my ($self, $id) = @_;

    my $direct = $self->fetch_by_id($id);
    my $return = $direct->next_route();
    $return->delete() if $return;
    $direct->delete();
}

sub params {
    my $self = shift;

    return {
        is_published  => $self->is_published,
        timetable_id  => $self->timetable_id,
        fare_class_id => $self->fare_class_id,
        parent_id     => $self->parent_id,
        cost          => $self->cost,
    };
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
