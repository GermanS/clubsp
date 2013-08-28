package ClubSpain::Model::TimeTable;
use Moose;
use namespace::autoclean;
use parent qw(ClubSpain::Model::Base);
use ClubSpain::Types;
use ClubSpain::Constants qw(:all);

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

has 'id'=> (
    is      => 'rw',
    reader  => 'get_id',
    writer  => 'set_id',
);
has 'is_published' => (
    is      => 'rw',
    reader  => 'get_is_published',
    writer  => 'set_is_published',
);
has 'is_free' => (
    is      => 'rw',
    reader  => 'get_is_free',
    writer  => 'set_is_free',
);
has 'flight_id' => (
    is      => 'rw',
    reader  => 'get_flight_id',
    writer  => 'set_flight_id',
);
has 'departure_date' => (
    is      => 'rw',
    reader  => 'get_departure_date',
    writer  => 'set_departure_date',
);
has 'departure_time' => (
    is      => 'rw',
    reader  => 'get_departure_time',
    writer  => 'set_departure_time',
);
has 'arrival_date' => (
    is      => 'rw',
    reader  => 'get_arrival_date',
    writer  => 'set_arrival_date',
);
has 'arrival_time' => (
    is      => 'rw',
    reader  => 'get_arrival_time',
    writer  => 'set_arrival_time',
);
has 'airplane_id' => (
    is      => 'rw',
    reader  => 'get_airplane_id',
    writer  => 'set_airplane_id',
);

with 'ClubSpain::Model::Role::TimeTable';

sub create {
    my $self = shift;

    $self -> SUPER::create( $self -> params() );
}

sub update {
    my $self = shift;

    $self -> check_for_class_method();
    $self -> SUPER::update( $self -> params() );
}

sub departures {
    my ($self, %params) = @_;

    return
        $self -> schema()
              -> resultset($self -> source_name)
              -> departures(%params);
}

sub arrivals {
    my ($self, %params) = @_;

    return
        $self -> schema()
              -> resultset($self -> source_name)
              -> arrivals(%params);
}

sub searchCitiesOfDeparture {
    my $self = shift;

    return
        $self -> schema()
              -> resultset('ViewTimeTable')
              -> searchCitiesOfDeparture();
}

sub searchCitiesOfArrival {
    my ($self, %params) = @_;

    return
        $self -> schema()
              -> resultset('ViewTimeTable')
              -> searchCitiesOfArrival(%params);
}

sub searchDatesOfDeparture {
    my ($self, %params) = @_;

    return
        $self -> schema()
              -> resultset('ViewTimeTable')
              -> searchDatesOfDeparture(%params);
}

sub searchTimetable {
    my ($self, %params) = @_;

    return
        $self -> schema()
              -> resultset('ViewTimeTable')
              -> searchTimetable(%params);
}

sub disable_tariffs {
    my ($self, %params) = @_;

    my $tariffs = $params{'timetable'} -> itineraries;
    while (my $route = $tariffs -> next) {
        if ($route -> parent_id) {
            $self -> schema()
                  -> resultset('Itinerary')
                  -> single({ id => $route -> parent_id })
                  -> update({ is_published => DISABLE });
        } else {
            $route -> update({ is_published => DISABLE });
        }
    }
}

sub enable_tariffs {
    my ($self, %params) = @_;

    my $tariffs = $params{'timetable'} -> itineraries;
    while (my $route = $tariffs -> next) {
        if ($route -> parent_id) {
            $self -> schema
                  -> resultset('Itinerary')
                  -> single({ id => $route -> parent_id })
                  -> update({
                     is_published => ENABLE
                 });
        } else {
            $route -> update({
                is_published => ENABLE
            });
        }
    }
}

sub set_free {
    my ($self, %params) = @_;
    $params{'timetable'} -> update({ is_free => FREE });

    $self -> enable_tariffs(%params);
}
sub set_request {
    my ($self, %params) = @_;
    $params{'timetable'} -> update({ is_free => REQUEST });
}

sub set_sold {
    my ($self, %params) = @_;

    $params{'timetable'} -> update({ is_free => SOLD });
    $self -> disable_tariffs(%params);
}

__PACKAGE__ -> meta -> make_immutable();

1;

__END__

=pod

=head1 NAME

ClubSpain::Model::TimeTable

=head1 DESCRIPTION

Расписание рейсов

=head1 FIELDS

=head2 airplane_id

Идентификатор марки самолета

=head2 arrival_date

Дата прибытия

=head2 arrival_time

Время прибытия

=head2 departure_date

Дата отправления

=head2 departure_time

Время отправления

=head2 flight_id

Идентификатор рейса

=head2 is_free

Флаг наличия сободных мест на рейсе

=head2 is_published

Флаг опубликованности

=head1 METHODS

=head2 create()

Добавление объекта в базу данных.

=head2 update()

Редактирование объекта в базе данных

=head2 departures(cityOfDeparture => , [duration => ])

Получение расписание вылетов из указанного города начиная с текущего момента
плюс колическов указанных дней
На входе:
    cityOfDeparture - город вылета
    duration        - количество дней за которое необходимо паказать расписание
                      (необязательный параметр)

На выходе
    $iterator - итератор расписаний


=head2 arrivals(cityOfArrival => , [duration => ])

Получение расписания прилетов в указанный город начиная с текущего момента
плюс колическов указанных дней

На входе:
    cityOfArrival - город прилета
    duration      - количество дней за которое необходимо паказать расписание
                    (необязательный параметр)

Нам выходе
    $iterator  - итератор расписаний

=head2 searchCitiesOfDeparture()

Получение списка городов отправления из расписания
На выходе:
    $iterator - итератор городов отправления в расписании

У всех объектов: стран, городов, аэропортов, ... должен стоять флаг is_published=1

=cut

=head2 searchCitiesOfArrival(cityOfDeparture => )

Получение списка гододов прибытия из указанного города отправления

На входе:
    cityOfDeparture - годод отправления

Но выходе:
    $iterator - итератор городов прибытия из города отправления

У всех объектов: стран, городов, аэропортов, ... должен стоять флаг is_published=1


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

=head2 searchTimetable(cityOfDeparture => , cityOfArrival => , dateOfDeparture =>)

Получение расписания по критерию

На входе:
    cityOfDeparture - город отправление
    cityOfArrival   - город прибытия
    dateOfDeparture - дата отправления

На выходе:
    $iterator всех найденных вариантов удовлетворяющих критериям
    или undef если не заданы обязательные параметры.

=head2 disable_tariffs(%params)

Скрытие всех тарифов у расписания
На входе:
    timetable  - объект типа TimeTable

=head2 enable_tariffs(%params)

Открытие всех тарифов у расписания
На входе:
    timetable  - объект типа TimeTable

=cut

=head set_free(%params)

Установка флага доступности тарифа в положение "МЕСТА ЕСТЬ"
Открываются все тарифы для указанного расписания
На входе:
    timetable  - объект типа TimeTable


=head set_request(%params)

Установка флага доступности тарифа в положение "МЕСТ МАЛО"
На входе:
    timetable  - объект типа TimeTable

=head set_sold(%params)

Установка флага доступности тарифа в положение "МЕСТ НЕТ"
Дополнительно скрываются все тарифы на расписание
На входе:

    timetable  - объект типа TimeTable

=head1 SEE ALSO

L<ClubSpain::Model::Role::TimeTable>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut
