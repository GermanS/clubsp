package ClubSpain::Model::Itinerary;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use Moose;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;
use ClubSpain::Constants qw(:all);

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'Itinerary' });

has 'id' => (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'is_published' => (
    is      => 'rw',
    reader  => 'get_is_published',
    writer  => 'set_is_published',
);
has 'timetable_id' => (
    is      => 'rw',
    reader  => 'get_timetable_id',
    writer  => 'set_timetable_id',
);
has 'return_segment' => (
    is      => 'rw',
    reader  => 'get_return_segment',
    writer  => 'set_return_segment',
);
has 'fare_class_id' => (
    is      => 'rw',
    reader  => 'get_fare_class_id',
    writer  => 'set_fare_class_id',
);
has 'parent_id' => (
    is      => 'rw',
    default => sub { 0 },
    reader  => 'get_parent_id',
    writer  => 'set_parent_id',
);
has 'cost' => (
    is      => 'rw',
    reader  => 'get_cost',
    writer  => 'set_cost',
);

with 'ClubSpain::Model::Role::Itinerary';

sub create {
    my $self = shift;

    $self -> SUPER::create( $self -> params() );
}

sub update {
    my $self = shift;

    $self -> check_for_class_method();
    $self -> SUPER::update( $self -> params() );
}

sub insert_fare {
    my $self = shift;

    my $direct = $self -> create();

    if ( $self -> get_return_segment() ) {
        my $return = $self -> new({
            timetable_id  => $self -> get_return_segment,
            fare_class_id => $self -> get_fare_class_id,
            parent_id     => $direct -> id,
            cost          => 0,
            is_published  => ENABLE,
        });

        $return -> create();
    }

    return $direct;
}

sub update_fare {
    my $self = shift;

    my $direct = $self -> update();
    my $return = $direct -> next_route();
    if ($return) {
        $return -> update({
            is_published  => $self -> get_is_published,
            fare_class_id => $self -> get_fare_class_id,
            cost          => 0
        });
    }

    return $direct;
}

sub delete_fare {
    my ($self, $id) = @_;

    my $direct = $self -> fetch_by_id($id);
    my $return = $direct -> next_route();
    $return -> delete() if $return;
    $direct -> delete();
}

sub searchItinerary {
    my ($self, @params) = @_;

    return
        $self -> schema()
              -> resultset($self -> source_name)
              -> searchItinerary(@params);
}

sub itineraries {
    my ($self, @params) = @_;

    return
        $self -> schema()
              -> resultset($self -> source_name)
              -> itineraries(@params);
}

sub searchDatesOfDepartureOW {
    my ($self, %params) = @_;

    return
        $self -> schema()
              -> resultset('ViewItineraryOW')
              -> searchDatesOfDeparture(%params);
}

sub searchDatesOfDeparture1RT {
    my ($self, %params) = @_;

    return
        $self -> schema()
              -> resultset('ViewItineraryRT')
              -> searchDatesOfDeparture1RT(%params);
}

sub searchDatesOfDeparture2RT {
    my ($self, %params) = @_;

    return
        $self -> schema()
              -> resultset('ViewItineraryRT')
              -> searchDatesOfDeparture2RT(%params);
}

__PACKAGE__ -> meta -> make_immutable;

1;

__END__

=pod

=head1 NAME

ClubSpain::Model::Itinerary

=head1 SYNOPSIS

    use ClubSpain::Model::Itinerary;
    my $object = ClubSpain::Model::Itinerary -> new(
        id            => $id,
        cost          => $cost,
        fare_class_id => $class_id,
        parent_id     => $parent_id,
        timetable_id  => $timetable,
    );

    my $res = $object -> create();
    my $res = $object -> update();


=head1 DESCRIPTION

Тариф на авиабилет

=head1 FIELDS

=head2 is_published

Флаг опубликованности

=head2 timetable_id

Идентификатор расписания

=head2 fare_class_id

Класс обслуживания

=head2 parent_id

Предыдущий сегмент

=head2 cost

Стоимость сегмента

=head1 METHODS

=head2 insert_fare()

Добавление тарифа для всех полетных сегментов

=head2 update_fare()

Редактирование тарифа для всех полетных сегментов

=head2 delete_fare()

Удаление тарифа и всех полетных сегментов

=head2 searchItinerary(@params)

Писк тарифов по идентификаторам расписания
timetable1, [timetable2]

=head2 itiniraries( @params )

Поиск тарифов по городам вылета и прилета

{cityOfDFeparture => , cityOfArrival => }, [{cityOfDFeparture => , cityOfArrival => }]

=head2 searchDatesOfDepartureOW(%params)

Поиск дат отправление среди тарифов в одну сторону
из города отправления в город прибытия
На входе
    cityOfDeparture - город отправления
    cityOfarrival   - город прибытия
На выходе
    Даты отправления

=head2 searchDatesOfDeparture1RT(%params)

Поиск дат отправления в первом сегменте тарифа в обе стороны
На входе
    cityOfDeparture1 - первый город отправления
    cityOfArrival1   - первый город прибытия
    cityOfDeparture2 - второй город отправления
    cityOfArrival2   - второй город прибытия

На выходе
    Даты отправления первого сегмента

=head2 searchDatesOfDeparture2RT(%params)

Поиск дат отправления во втором сегменте тарифа в обе стороны
На входе
    cityOfDeparture1 - первый город отправления
    cityOfArrival1   - первый город прибытия
    dateOfDeparture1 - дата отправления
    cityOfDeparture2 - второй город отправления
    cityOfArrival2   - второй город прибытия

На выходе
    Даты отправления второго сегмента

=head1 SEE ALSO

L<Moose>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut