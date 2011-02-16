package ClubSpain::Controller::RPC::Flight::TimeTable;
use strict;
use warnings;

use base qw(Catalyst::Controller);

sub _getCitiesOfDeparture {
    my ($self, $c) = @_;

    my $iterator = $c->model('City')->search({
        'country.is_published' => 1,
        'me.is_published'      => 1,
        'airport.is_published' => 1,
        'flight.is_published'  => 1,
    }, {
        where  => [ -and => {
            'me.country_id '   => \'=country.id',
            'airport.city_id'  => \'=me.id',
        }],
        from     => [ 'city as me, country, airport, flight' ],
        group_by => 'me.id'
    });

    my @res;
    while (my $item = $iterator->next) {
        push @res, { id => $item->id, name => $item->name };
    }

    return @res;
}


sub _getCitiesOfArrival {
    my ($self, $c, $cityOfDeparture) = @_;

    my $iterator = $c->model('City')->search({
        'departure_country.is_published'   => 1,
        'destination_country.is_published' => 1,
        'departure_city.is_published'      => 1,
        'me.is_published'                  => 1,
        'departure_airport.is_published'   => 1,
        'destination_airport.is_published' => 1,
        'flight.is_published'              => 1,
        'departure_city.id'                => $cityOfDeparture,
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


    my @res;
    while (my $item = $iterator->next) {
        push @res, { id => $item->id, name => $item->name };
    }

    return @res;
}

sub _searchFlights {
    my ($self, $c, $params) = @_;

    return unless $params->{'cityOfDeparture'} && $params->{'cityOfArrival'};

    my $iterator = $c->model('Flight')->search({
            'departure_country.is_published'    => 1,
            'destination_country.is_published'  => 1,
            'departure_city.is_published'       => 1,
            'destination_city.is_published'     => 1,
            'departure_airport.is_published'    => 1,
            'destination_airport.is_published'  => 1,
            'me.is_published'                   => 1,
            'departure_city.id'   => $params->{'cityOfDeparture'},
            'destination_city.id' => $params->{'cityOfArrival'}
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

    my @res;
    while (my $item = $iterator->next) {
        my $name = sprintf "%s %s (%s - %s)",
            $item->airline->iata,
            $item->code,
            $item->departure_airport->iata,
            $item->destination_airport->iata;
        push @res, { id => $item->id, name => $name };
    }

    return @res;
}


1;
