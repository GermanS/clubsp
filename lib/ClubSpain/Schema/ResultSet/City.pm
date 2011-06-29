package ClubSpain::Schema::ResultSet::City;
use strict;
use warnings;
use parent qw(ClubSpain::Schema::ResultSet);


=head2 searchCitiesOfDeparture(counry => $country);

Получение списка городов отправления в которых
 - есть аэропорты
 - установлене флаг доступности is_published=1

 Внутренний метод, используемыый в бекофисе программы
 при работе с нумерацией рейсов.

=cut

sub searchCitiesOfDeparture {
    my ($self, %params) = @_;

    return
        unless $params{'country'};

    return
        $self->result_source->resultset->search({
            'country.is_published' => 1,
            'me.is_published'      => 1,
            'airport.is_published' => 1,
            'me.country_id'        => $params{'country'}
        }, {
            where => [ -and => {
                'me.country_id'   => \'=country.id',
                'airport.city_id' => \'=me.id'
            }],
            from     => [ 'city as me, airport, country' ],
            group_by => 'me.id',
        });
}


=head2 searchCitiesOfDepartureInFlight()

Получение списка городов отправления в которых
 - есть аэропорты
 - установлен флаг доступности is_published=1
 - есть хотя бы один авиарейс

 Внутренний метод, используемыый в бекофисе программы
 при работе с расписанием авиарейсов.

=cut


sub searchCitiesOfDepartureInFlight {
    my $self = shift;

    return
        $self->result_source->resultset->search({
            'country.is_published' => 1,
            'me.is_published'      => 1,
            'airport.is_published' => 1,
            'flight.is_published'  => 1,
        }, {
            where  => [ -and => {
                'me.country_id '              => \'=country.id',
                'airport.city_id'             => \'=me.id',
                'flight.departure_airport_id' => \'=airport.id'
            }],
            from     => [ 'city as me, country, airport, flight' ],
            group_by => 'me.id'
        });
}


=head2 searchCitiesOfArrivalInFlight(cityOfDeparture => $city)

Получение списка городов прибытия из указанного города отправления в которых
 - есть аэропорты
 - установлен флаг доступности is_published=1
 - есть хотя бы один авиарейс

 Внутренний метод, используемыый в бекофисе программы
 при работе с расписанием авиарейсов.

=cut


sub searchCitiesOfArrivalInFlight {
    my ($self, %params) = @_;

    return
        unless $params{'cityOfDeparture'};

    return
        $self->result_source->resultset->search({
            'departure_country.is_published'   => 1,
            'destination_country.is_published' => 1,
            'departure_city.is_published'      => 1,
            'me.is_published'                  => 1,
            'departure_airport.is_published'   => 1,
            'destination_airport.is_published' => 1,
            'flight.is_published'              => 1,
            'departure_city.id'                => $params{'cityOfDeparture'},
        }, {
            where  => [ -and => {
                'departure_city.country_id '    => \'=departure_country.id',
                'departure_airport.city_id'     => \'=departure_city.id',
                'flight.departure_airport_id'   => \'=departure_airport.id',
                'flight.destination_airport_id' => \'=destination_airport.id',
                'destination_airport.city_id'   => \'=me.id',
                'me.country_id'                 => \'=destination_country.id'
            }],
            from     => [ qq(city as me,
                             country as departure_country,
                             country as destination_country,
                             city as departure_city,
                             airport as departure_airport,
                             airport as destination_airport,
                             flight) ],
            group_by => 'me.id'
        });
}


=head2 searchCitiesOfDepartureInTimeTable()

Получение списка городов отправления в которых
 - есть аэропорты
 - установлен флаг доступности is_published=1
 - есть авиарейс
 - есть расписание, даты отправления больше чем текущее число

=cut

sub searchCitiesOfDepartureInTimeTable {
    my $self = shift;

    return $self->result_source->resultset->search({
            'departure_country.is_published'    => 1,
            'destination_country.is_published'  => 1,
            'me.is_published'                   => 1,
            'destination_city.is_published'     => 1,
            'departure_airport.is_published'    => 1,
            'destination_airport.is_published'  => 1,
            'flight.is_published'               => 1,
            'timetable.is_published'            => 1,
            'timetable.departure_date'          => \'>=NOW()',
    }, {
            where  => [ -and => {
                'me.country_id '                => \'=departure_country.id',
                'departure_airport.city_id'     => \'=me.id',
                'flight.departure_airport_id'   => \'=departure_airport.id',
                'flight.destination_airport_id' => \'=destination_airport.id',
                'destination_airport.city_id'   => \'=destination_city.id',
                'destination_city.country_id'   => \'=destination_country.id',
                'timetable.flight_id'           => \'=flight.id',
            }],
            from     => [ qq(country as departure_country,
                             country as destination_country,
                             city as me,
                             city as destination_city,
                             airport as departure_airport,
                             airport as destination_airport,
                             flight,
                             timetable) ],
            group_by => 'me.id'
    });
}

=head2 searchCitiesOfArrivalInTimeTable(cityOfDeparture => $cityOfDeparture)

Получение списка городов прибытия в которых
 - есть аэропорты
 - установлен флаг доступности is_published=1
 - есть авиарейс
 - есть расписание, даты отправления больше чем текущее число

=cut

sub searchCitiesOfArrivalInTimeTable {
    my ($self, %params) = @_;

    return
        unless $params{'cityOfDeparture'};

    return $self->result_source->resultset->search({
            'departure_country.is_published'    => 1,
            'destination_country.is_published'  => 1,
            'departure_city.is_published'       => 1,
            'me.is_published'                   => 1,
            'departure_airport.is_published'    => 1,
            'destination_airport.is_published'  => 1,
            'flight.is_published'               => 1,
            'timetable.is_published'            => 1,
            'timetable.departure_date'          => \'>=NOW()',
            'departure_city.id'                 => $params{'cityOfDeparture'}
    }, {
            where  => [ -and => {
                'departure_city.country_id '    => \'=departure_country.id',
                'departure_airport.city_id'     => \'=departure_city.id',
                'flight.departure_airport_id'   => \'=departure_airport.id',
                'flight.destination_airport_id' => \'=destination_airport.id',
                'destination_airport.city_id'   => \'=me.id',
                'me.country_id'                 => \'=destination_country.id',
                'timetable.flight_id'           => \'=flight.id',
            }],
            from     => [ qq(country as departure_country,
                             country as destination_country,
                             city as departure_city,
                             city as me,
                             airport as departure_airport,
                             airport as destination_airport,
                             flight,
                             timetable) ],
            group_by => 'me.id'
    });
}


=head2 searchCityOFDepartureInOWItinerary()

Получение городов отправления для тарифов в одну сторону

=cut

sub searchCitiesOfDepartureInOWItinerary {
    my ($self) = @_;

    return $self->result_source->resultset->search({
        'itineraries.parent_id'          => 0,
        'children.id'                    => \'IS NULL',
        'time_tables.departure_date'      => \'>=NOW()',

        'country.is_published'           => 1,
        'me.is_published'                => 1,
        'airports.is_published'          => 1,
        'departure_flights.is_published' => 1,
        'time_tables.is_published'       => 1,
        'itineraries.is_published'       => 1,
        'destination_airport.is_published' => 1,
        'city.is_published'      => 1,
        'country_2.is_published' => 1,
    }, {
        join => [
            'country', {
                'airports' => {
                    'departure_flights' => [
                        {
                            'time_tables' => { 'itineraries' => 'children' }
                        },
                        {
                            'destination_airport' => { 'city' => 'country' }
                        }
                    ],
                }
        }],
        group_by  => [ 'me.id' ]
    });
}

=head searchCitiesOfArrivalInOWItinerary( cityOfDeparture => )

Поиск городов прибытия из города отправления

=cut

sub searchCitiesOfArrivalInOWItinerary {
    my ($self, %params) = @_;

    return $self->result_source->resultset->search({
        'itineraries.parent_id'          => 0,
        'children.id'                    => \'IS NULL',
        'time_tables.departure_date'     => \'>=NOW()',
        'departure_airport.city_id'      => $params{'cityOfDeparture'},

        'country.is_published'           => 1,
        'me.is_published'                => 1,
        'airports.is_published'          => 1,
        'arrival_flights.is_published'   => 1,
        'time_tables.is_published'       => 1,
        'itineraries.is_published'       => 1,
        'departure_airport.is_published' => 1,
        'city.is_published'      => 1,
        'country_2.is_published' => 1,
    }, {
        join => [
            'country', {
                'airports' => {
                    'arrival_flights' => [
                        {
                            'time_tables' => { 'itineraries' => 'children' }
                        },
                        {
                            'departure_airport' => { 'city' => 'country' }
                        }
                    ],
                }
        }],
        group_by  => [ 'me.id' ]
    });
}

1;
