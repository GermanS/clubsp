package ClubSpain::Schema::ResultSet::TimeTable;
use strict;
use warnings;
use parent qw(ClubSpain::Schema::ResultSet);

=head2 searchDatesOfDepature(cityOfDeparture => $city, cityOfArrival => $city)

Получение дат отправления из города cityOfDeparture в город cityOfArrival

все флаги должны быть выставлены в единицу

=cut

sub searchDatesOfDeparture {
    my ($self, %params) = @_;

    return
        unless $params{'cityOfDeparture'} && $params{'cityOfArrival'};

    return $self->result_source->resultset->search({
            'departure_country.is_published'    => 1,
            'destination_country.is_published'  => 1,
            'departure_city.is_published'       => 1,
            'destination_city.is_published'     => 1,
            'departure_airport.is_published'    => 1,
            'destination_airport.is_published'  => 1,
            'flight.is_published'               => 1,
            'me.is_published'                   => 1,
            'me.departure_date'                 => \'>=NOW()',
            'departure_city.id'                 => $params{'cityOfDeparture'},
            'destination_city.id'               => $params{'cityOfArrival'}
    }, {
            where  => [ -and => {
                'departure_city.country_id '    => \'=departure_country.id',
                'departure_airport.city_id'     => \'=departure_city.id',
                'flight.departure_airport_id'   => \'=departure_airport.id',
                'flight.destination_airport_id' => \'=destination_airport.id',
                'destination_airport.city_id'   => \'=destination_city.id',
                'destination_city.country_id'   => \'=destination_country.id',
                'me.flight_id'                  => \'=flight.id',
            }],
            from     => [ qq(country as departure_country,
                             country as destination_country,
                             city as departure_city,
                             city as destination_city,
                             airport as departure_airport,
                             airport as destination_airport,
                             flight,
                             timetable as me) ],
            group_by => 'me.departure_date'
    });
}

1;
