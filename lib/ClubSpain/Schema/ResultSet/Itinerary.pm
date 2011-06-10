package ClubSpain::Schema::ResultSet::Itinerary;
use strict;
use warnings;
use parent qw(ClubSpain::Schema::ResultSet);

sub searchItinerary {
    my ($self, @params) = @_;

    my $iterator;
    if (scalar @params == 1) {
        $iterator = $self->searchOneWay($params[0])
    } else {
        $iterator = $self->searchRoundTrip(@params);
    }

    return $iterator;
}

sub searchOneWay {
    my ($self, $timetable_id) = @_;

#select *
#    from itinerary as i1
#    left join itinerary as i2 on i2.parent_id = i1.id
#    where i2.id IS  NULL and i1.parent_id=0;

    return $self->result_source->resultset->search({
        'me.timetable_id' => $timetable_id,
        'me.parent_id'    => 0,
        'children.id'     => \'iS NULL'
    }, {
        join => 'children'
    });
}


sub searchRoundTrip {
    my ($self, @timetable_id) = @_;

#   select *
#    from itinerary as i1
#    left join itinerary as i2 on i2.parent_id = i1.id
#    where
#    i1.timetable_id = 7 and
#    i2.timetable_id = 11

    return $self->result_source->resultset->search({
        'me.timetable_id'       => $timetable_id[0],
        'children.timetable_id' => $timetable_id[1]
    }, {
        prefetch => 'children'
    });
}

sub itineraries {
    my ($self, @params) = @_;
    my $iterator;

    if (scalar @params == 1) {
        $iterator = $self->__itineraries_OW(@params);
    } elsif (scalar @params == 2) {
        $iterator = $self->__itineraries_RT(@params);
    } else {
        die "only one or two segments allowed";
    }

    $iterator->result_class('DBIx::Class::ResultClass::HashRefInflator')
        unless $params[0]->{'asObject'};

    return $iterator;
}

#Поиск всех билетов OW по идентификаторам городов вылета и прилета
# по дате вылета
#select *
#    from itinerary as i1
#   left join itinerary as i2 on i2.parent_id = i1.id
#    left join timetable as t on t.id = i1.timetable_id
#    left join flight as f on f.id = t.flight_id
#    left join airport as departure on f.departure_airport_id = departure.id
#    left join airport as arrival   on f.destination_airport_id = arrival.id
#    where
#    departure.city_id = 1 and
#    arrival.city_id = 2 and
#    timetable.departure_date = '2011-01-01' and
#    i2.id IS  NULL and i1.parent_id=0;

# { cityOfDeparture => , cityOfArrival => , [dateOfDeparture => ]}
sub __itineraries_OW {
    my ($self, @params) = @_;

    my $cityOfDeparture = $params[0]->{'cityOfDeparture'};
    my $cityOfArrival   = $params[0]->{'cityOfArrival'};
    my $dateOfDeparture = $params[0]->{'dateOfDeparture'};

    my %condition = (
        'me.parent_id'    => 0,
        'children.id'     => \'IS NULL',
        'departure_airport.city_id'    => $cityOfDeparture,
        'destination_airport.city_id'  => $cityOfArrival,
    );
    $condition{'timetable.departure_date'} = $dateOfDeparture
        if $dateOfDeparture;

    my %show_hidden = (
        'me.is_published' => 1,
        'timetable.is_published' => 1,
        'flight.is_published' => 1,
        'departure_airport.is_published' => 1,
        'destination_airport.is_published' => 1,
        'city.is_published' => 1,
        'city_2.is_published' => 1,
        'country.is_published' => 1,
        'country_2.is_published' => 1,
    );

    %condition = (%condition, %show_hidden)
        unless $params[0]->{'showHidden'};

    return $self->result_source->resultset->search({
        %condition,
    }, {
        join => [
            'children', {
                'timetable' => {
                    'flight' => [{
                        'departure_airport'=> {
                            'city' => 'country'
                        },
                        'destination_airport' => {
                            'city' => 'country'
                        }
                    }]
                }
            }
        ],
        order_by  => [
            'timetable.departure_date',
            'timetable.departure_time',
            'me.fare_class_id'
        ],
        prefetch => [{
            'timetable' => [{
                'flight' => [{
                        'departure_airport' => {
                            'city' => 'country'
                        },
                        'destination_airport' => {
                            'city' => 'country'
                        }
                    },
                    'airline'
                ]},
                'airplane'
            ]},
            'fare_class'
        ]
    });
}

#   select *
#    from itinerary as i1
#    left join itinerary as i2 on i2.parent_id = i1.id
#    left join timetable as t1 on t1.id = i1.timetable_id
#    left join flight as f1 on f1.id = t1.flight_id
#    left join airport as departure1 on f1.departure_airport_id = departure1.id
#    left join airport as arrival1   on f1.destination_airport_id = arrival1.id
#    /* return */
#    left join timetable as t2 on t2.id = i2.timetable_id
#    left join flight as f2 on f2.id = t2.flight_id
#    left join airport as departure2 on f2.departure_airport_id = departure2.id
#    left join airport as arrival2   on f2.destination_airport_id = arrival2.id
#    where
#    departure1.city_id = 1 and
#    arrival1.city_id = 2 and
#    departure2.city_id = 2 and
#    arrival2.city_id = 1
sub __itineraries_RT {
    my ($self, @params) = @_;

    my $cityOfDeparture1 = $params[0]->{'cityOfDeparture'};
    my $cityOfArrival1   = $params[0]->{'cityOfArrival'};
    my $dateOfDeparture1 = $params[0]->{'dateOfDeparture'};

    my $cityOfDeparture2 = $params[1]->{'cityOfDeparture'};
    my $cityOfArrival2   = $params[1]->{'cityOfArrival'};
    my $dateOfDeparture2 = $params[1]->{'dateOfDeparture'};

    my %condition = (
        'departure_airport.city_id'     => $cityOfDeparture1,
        'destination_airport.city_id'   => $cityOfArrival1,
        'departure_airport_2.city_id'   => $cityOfDeparture2,
        'destination_airport_2.city_id' => $cityOfArrival2,
    );
    $condition{'timetable.departure_date'} = $dateOfDeparture1
        if defined $dateOfDeparture1 && $dateOfDeparture1;
    $condition{'timetable_2.departure_date'} = $dateOfDeparture2
        if defined $dateOfDeparture2 && $dateOfDeparture2;

    my %show_hidden = (
        'me.is_published' => 1,
        'timetable.is_published' => 1,
        'timetable_2.is_published' => 1,
        'flight.is_published' => 1,
        'flight_2.is_published' => 1,
        'departure_airport.is_published' => 1,
        'departure_airport_2.is_published' => 1,
        'destination_airport.is_published' => 1,
        'destination_airport_2.is_published' => 1,
        'city.is_published' => 1,
        'city_2.is_published' => 1,
        'city_3.is_published' => 1,
        'city_4.is_published' => 1,
        'country.is_published' => 1,
        'country_2.is_published' => 1,
        'country_3.is_published' => 1,
        'country_4.is_published' => 1,
    );

    %condition = (%condition, %show_hidden)
        unless $params[0]->{'showHidden'} && $params[1]->{'showHidden'};

    return $self->result_source->resultset->search({
        %condition
    }, {
        join => [{
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
            }, {
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
            }
        ],
        order_by  => [
            'timetable.departure_date',
            'timetable.departure_time',
            'timetable_2.departure_date',
            'timetable_2.departure_time',
            'me.fare_class_id'
        ],
        prefetch => [{
            'timetable' => [{
                'flight' => [{
                        'departure_airport' => {
                            'city' => 'country'
                        },
                        'destination_airport' => {
                            'city' => 'country'
                        },
                    },
                    'airline' ]
                },
                'airplane' ]
            }, {
                'children' => [{
                    'timetable' => [{
                        'flight' => [{
                            'departure_airport' => {
                                'city' => 'country'
                            },
                            'destination_airport' => {
                                'city' => 'country'
                            },
                        },
                        'airline' ]
                    },
                    'airplane' ]
                },
                'fare_class' ]
            },
            'fare_class'
        ]
    });
}

1;

__END__
