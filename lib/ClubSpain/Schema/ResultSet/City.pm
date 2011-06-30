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

sub searchCitiesOfDeparture1InRTItinerary {
    my $self = shift;

    return $self->result_source->resultset->search({
        'timetable.departure_date' => \'>=NOW()',

    }, {
        join => [{
            'airports' => {
                'departure_flights' => {
                    'time_tables' => {
                        'itineraries' => [{
                            'timetable' => {
                                'flight' => [{
                                    'departure_airport' => {
                                        'city' => 'country'
                                    },
                                    'destination_airport' => {
                                        'city' => 'country'
                                    }
                                }]
                            }
                        },
                        {
                            'children' => {
                                'timetable' => {
                                    'flight' => [{
                                        'departure_airport' => {
                                            'city' => 'country'
                                        },
                                        'destination_airport' => {
                                            'city' => 'country'
                                        }
                                    }]
                                }
                            }
                        }]
                    }
                }
            }
        }],
        group_by  => [ 'me.id' ]
    });
}

1;

__END__

[{
            'airports' => {
                'departure_flights' => {
                    'time_tables' => {
                        'itineraries' => [{
                            'timetable' => {
                                'flight' => [{
                                    'departure_airport' => {
                                        'city' => 'country'
                                    },
                                    'destination_airport' => {
                                        'city' => 'country'
                                    }
                                }]
                            }
                        },
                        {
                            'children' => {
                                'timetable' => {
                                    'flight' => [{
                                        'departure_airport' => {
                                            'city' => 'country'
                                        },
                                        'destination_airport' => {
                                            'city' => 'country'
                                        }
                                    }]
                                }
                            }
                        }]
                    }
                }
            }
        }],
