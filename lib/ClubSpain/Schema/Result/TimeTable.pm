package ClubSpain::Schema::Result::TimeTable;

use strict;
use warnings;
use utf8;

use parent qw(ClubSpain::Schema::Result);
use ClubSpain::Constants qw(:all);

__PACKAGE__ -> load_components( qw(Core PK::Auto) );
__PACKAGE__ -> table( 'timetable' );
__PACKAGE__ -> source_name( 'TimeTable' );
__PACKAGE__ -> add_columns(
    id => {
        data_type         => 'integer',
        is_auto_increment => 1
    },
    is_published => {
        data_type   => 'TINYINT(1) UNSIGNED',
        is_nullable => 0,
    },
    is_free => {
        data_type   => 'integer',
        is_nullable => 0,
    },
    flight_id => {
        data_type      => 'integer',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    airplane_id => {
        data_type      => 'integer',
        is_nullable    => 0,
        is_foreign_key => 1,
    },
    departure_terminal_id => {
        data_type      => 'integer',
        is_nullable    => 1,
        is_foreign_key => 1,
    },
    arrival_terminal_id => {
        data_type      => 'integer',
        is_nullable    => 1,
        is_foreign_key => 1,
    },
    departure_date => {
        data_type      => 'date',
        is_nullable    => 0,
    },
    departure_time => {
        data_type      => 'time',
        is_nullable    => 1,
    },
    arrival_date => {
        data_type      => 'date',
        is_nullable    => 0,
    },
    arrival_time => {
        data_type      => 'time',
        is_nullable    => 1,
    },
);

__PACKAGE__ -> set_primary_key('id');
__PACKAGE__ -> add_unique_constraint( on_flight_departure_date => [ qw(flight_id departure_date arrival_date) ] );

__PACKAGE__ -> belongs_to(
    'departure_terminal' => 'ClubSpain::Schema::Result::Terminal', 'departure_terminal_id'
);
__PACKAGE__ -> belongs_to(
    'arrival_terminal'   => 'ClubSpain::Schema::Result::Terminal', 'arrival_terminal_id'
);
__PACKAGE__ -> belongs_to(
    'flight'   => 'ClubSpain::Schema::Result::Flight', 'flight_id'
);
__PACKAGE__ -> belongs_to(
    'airplane' => 'ClubSpain::Schema::Result::Airplane', 'airplane_id'
);

__PACKAGE__ -> has_many(
    'itineraries' => 'ClubSpain::Schema::Result::Itinerary',
    { 'foreign.timetable_id' => 'self.id' },
    { cascade_delete => 0 }
);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table -> add_index( name => 'on_dateOfDeparture', fields => ['departure_date'] );
    $sqlt_table -> add_index( name => 'on_is_published', fields => ['is_published'] );
}

sub is_FREE {
    return shift -> is_free == FREE;
}

sub is_REQUEST {
    return shift -> is_free == REQUEST;
}

sub is_SOLD {
    return shift -> is_free == SOLD;
}

sub to_hash {
    my $self = shift;

    my $flightNumber =
        sprintf "%2s %4s", $self-> flight -> airline -> iata,
                           $self-> flight -> code;
    return {
        id            => $self -> id,
        isFree        => $self -> is_free,
        dateBegin     => $self -> departure_date,
        timeBegin     => $self -> departure_time,
        dateEnd       => $self -> arrival_date,
        timeEnd       => $self -> arrival_time,
        board         => $self -> airplane -> to_hash(),
        airline       => $self -> flight -> airline -> to_hash(),
        flightNumber  => $flightNumber,
        locationBegin => {
            city    => $self -> flight -> departure_airport -> city -> to_hash(),
            airport => $self -> flight -> departure_airport -> to_hash(),
        },
        locationEnd => {
            city    => $self -> flight -> destination_airport -> city -> to_hash(),
            airport => $self -> flight -> destination_airport -> to_hash()
        }
    };
}

1;

__END__

=pod

=head1 NAME

ClubSpain::Schema::Result::TimeTable

=head1 DESCRIPTON

Модель таблицы timetable - расписание вылетов.

=head1 FIELDS

=head2 id

Идентфикатор расписания авиарейса

=head2 is_published

Флаг опубликованности расписания

=head2 is_free

Наличие свободных мест для данного полетного сегмента

=head2 flight_id

Идентификатор рейса

=head2 airplane_id

Идентификатор типа воздушного судна

=head2 departure_terminal_id

Идентификатор терминала отправления

=head2 arrival_terminal_id

Идентификатор терминала прибытия

=head2 departure_date

Дата отправления

=head2 departure_time

Время отправления

=head2 arrival_date

Дата прибытия

=head2 arrival_time

Время прибытия

=head1 INDEXES

=head2 on_flight_departure_date

Уникальный индекс по полям flight_id departure_date arrival_date

=head1 METHODS

=head2 departure_terminal()

Получение терминала вылета

=head2 arrival_terminal()

Получение терминала прилета

=head2 flight()

Получение маршрута

=head2 airplane()

Получение нвоздушного судна, выполняющего рейс

=head2 itineraries()

Получение списка тарифов для данного вылета (расписания)

=head2 is_FREE()

Возвращает true, если есть места на рейсе.

=head2 is_REQUEST()

Возвращает true, если места на рейсе по запросу.

=head2 is_SOLD()

Возвращает true, если мест на рейсе нет.

=head1 SEE ALSO

L<ClubSpain::Schema::Result::Airplane>
L<ClubSpain::Schema::Result::Flight>
L<ClubSpain::Schema::Result::Itinerary>
L<ClubSpain::Schema::Result::Terminal>
L<DBIx::Class>

=head1 AUTHOR

German Semenkov
german.semenkov@gmail.com

=cut