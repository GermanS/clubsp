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

1;

__END__


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
