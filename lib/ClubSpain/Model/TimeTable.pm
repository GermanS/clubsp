package ClubSpain::Model::TimeTable;
use Moose;
use namespace::autoclean;
use utf8;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;

use MooseX::ClassAttribute;
class_has '+source_name' => ( default => sub  { 'TimeTable' });

=head2 Поля

=over

=item id

    Идентификатор объекта

=item is_published

    Флаг опубликованности

=item flight_id

    Идентификатор рейса

=item departure_date

    Дата отправления

=item departure_time

    Время отправления

=item arrival_date

    Дата прибытия

=item arrival_time

    Время прибытия

=item departure_terminal_id

    Идентификатор терминала отправления

=item arrival_terminal_id

    Идентификатор терминала прибытия

=back

=cut

has 'id'                    => ( is => 'ro' );
has 'is_published'          => ( is => 'ro', required => 1 );
has 'flight_id'             => ( is => 'ro', required => 1 );
has 'departure_date'        => ( is => 'ro', required => 1 );
has 'departure_time'        => ( is => 'ro', required => 1 );
has 'arrival_date'          => ( is => 'ro', required => 1 );
has 'arrival_time'          => ( is => 'ro', required => 1 );
has 'airplane_id'           => ( is => 'ro' );
has 'departure_terminal_id' => ( is => 'ro' );
has 'arrival_terminal_id'   => ( is => 'ro' );

=head2 create()

    Добавление объекта в базу данных.

=cut

sub create {
    my $self = shift;

    $self->SUPER::create({
        is_published    => $self->is_published,
        flight_id       => $self->flight_id,
        departure_date  => $self->departure_date,
        departure_time  => $self->departure_time,
        arrival_date    => $self->arrival_date,
        arrival_time    => $self->arrival_time,
        airplane_id     => $self->airplane_id,
        departure_terminal_id   => $self->departure_terminal_id,
        arrival_terminal_id     => $self->arrival_terminal_id,
    });
}

=head2 update()

    Редактирование обхекта в базе данных

=cut

sub update {
    my $self = shift;

    $self->check_for_class_method();

    return $self->SUPER::update({
        is_published    => $self->is_published,
        flight_id       => $self->flight_id,
        departure_date  => $self->departure_date,
        departure_time  => $self->departure_time,
        arrival_date    => $self->arrival_date,
        arrival_time    => $self->arrival_time,
        airplane_id     => $self->airplane_id,
        departure_terminal_id   => $self->departure_terminal_id,
        arrival_terminal_id     => $self->arrival_terminal_id,
    });
}

=head2 departures(cityOfDeparture => , [duration => ])

    Получение расписание вылетов из указанного города начиная с текущего момента
    плюс колическов указанных дней

На входе:

    cityOfDeparture - город вылета
    duration        - количество дней за которое необходимо паказать расписание
                      (необязательный параметр)

На выходе

    $iterator - итератор расписаний

=cut

sub departures {
    my ($self, %params) = @_;

    return
        $self->schema()
             ->resultset($self->source_name)
             ->departures(%params);
}

=head2 arrivals(cityOfArrival => , [duration => ])

    Получение расписания прилетов в указанный город начиная с текущего момента
    плюс колическов указанных дней

На входе:

    cityOfArrival - город прилета
    duration      - количество дней за которое необходимо паказать расписание
                    (необязательный параметр)

Нам выходе

    $iterator  - итератор расписаний

=cut

sub arrivals {
    my ($self, %params) = @_;

    return
        $self->schema()
             ->resultset($self->source_name)
             ->arrivals(%params);
}

=head2 searchCitiesOfDeparture()

    Получение списка городов отправления из расписания

На выходе:

    $iterator - итератор городов отправления в расписании

У всех объектов: стран, городов, аэропортов, ... должен стоять флаг is_published=1

=cut

sub searchCitiesOfDeparture {
    my $self = shift;

    return
        $self->schema()
             ->resultset('ViewTimeTable')
             ->searchCitiesOfDeparture();
}

=head2 searchCitiesOfArrival(cityOfDeparture => )

    Получение списка гододов прибытия из указанного города отправления

На входе:

    cityOfDeparture - годод отправления

Но выходе:

    $iterator - итератор городов прибытия из города отправления

У всех объектов: стран, городов, аэропортов, ... должен стоять флаг is_published=1

=cut

sub searchCitiesOfArrival {
    my ($self, %params) = @_;

    return
        $self->schema()
             ->resultset('ViewTimeTable')
             ->searchCitiesOfArrival(%params);
}

=head2 searchDatesOfDeparture(cityOfDeparture => , cityOfArrival =>, [ startDate => ] )

    Получение дат отправления из города cityOfDeparture в город cityOfArrival
    начиная с даты startDate

На входе:

    cityOfDeparture - годор отправления
    cityOfArrival   - город прибытия
    startDate       - дата начала (необязательный параметр)

На выходе:

  $iterator - итератор дат вылета

У всех объектов: стран, городов, аэропортов, ... должен стоять флаг is_published=1

=cut

sub searchDatesOfDeparture {
    my ($self, %params) = @_;

    return
        $self->schema()
             ->resultset('ViewTimeTable')
             ->searchDatesOfDeparture(%params);
}

=head2 searchTimetable(cityOfDeparture => , cityOfArrival => , dateOfDeparture =>)

    Получение расписания по критерию

На входе:

    cityOfDeparture - город отправление
    cityOfArrival   - город прибытия
    dateOfDeparture - дата отправления

На выходе:

    $iterator всех найденных вариантов удовлетворяющих критериям
    или undef если не заданы обязательные параметры.

=cut

sub searchTimetable {
    my ($self, %params) = @_;

    return
        $self->schema()
             ->resultset('ViewTimeTable')
             ->searchTimetable(%params);
}

__PACKAGE__->meta->make_immutable;

1;
