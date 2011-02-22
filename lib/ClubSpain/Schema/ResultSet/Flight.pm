package ClubSpain::Schema::ResultSet::Flight;
use strict;
use warnings;
use parent qw(ClubSpain::Schema::ResultSet);

=head2 searchFlights(cityOfDeparture => ..., cityOfArrival => ... )

Получение списка авиарейстов из города вылета - cityOfDeparture,
в город прилета - cityOfArival
при условии что у всех перелетов установлен флаг видимости is_published

 Внутренний метод, используемыый в бекофисе программы
 при работе с расписанием

=cut

sub searchFlights {
    my ($self, %params) = @_;

    return
        unless $params{'cityOfDeparture'} && $params{'cityOfArrival'};

    return
        $self->result_source->resultset->search({
            'departure_country.is_published'    => 1,
            'destination_country.is_published'  => 1,
            'departure_city.is_published'       => 1,
            'destination_city.is_published'     => 1,
            'departure_airport.is_published'    => 1,
            'destination_airport.is_published'  => 1,
            'me.is_published'                   => 1,
            'departure_city.id'   => $params{'cityOfDeparture'},
            'destination_city.id' => $params{'cityOfArrival'}
        }, {
            where  => [ -and => {
                'departure_city.country_id '    => \'=departure_country.id',
                'departure_airport.city_id'     => \'=departure_city.id',
                'me.departure_airport_id'       => \'=departure_airport.id',
                'me.destination_airport_id'     => \'=destination_airport.id',
                'destination_airport.city_id'   => \'=destination_city.id',
                'destination_city.country_id'   => \'=destination_country.id',
            }],
            from     => [ qq(country as departure_country,
                             country as destination_country,
                             city as departure_city,
                             city as destination_city,
                             airport as departure_airport,
                             airport as destination_airport,
                             flight as me) ],
            group_by => 'me.id'
        });
}

1;
