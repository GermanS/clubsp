package ClubSpain::Schema::Result::ViewTimeTable;
use strict;
use warnings;
use utf8;
use parent qw(DBIx::Class::Core);

__PACKAGE__->table_class('DBIx::Class::ResultSource::View');
__PACKAGE__->table('ViewTimeTable');
__PACKAGE__->result_source_instance->is_virtual(1);
__PACKAGE__->result_source_instance->view_definition(q[
SELECT countryOfDeparture.id   as countryOfDeparureId,
       countryOfDeparture.name as countryOfDepartureName,
       countryOfArrival.id   as countryOfArrivalId,
       countryOfArrival.name as countryOfArrivalName,
       cityOfDeparture.id   as cityOfDepartureId,
       cityOfDeparture.name as cityOfDepartureName,
       cityOfDeparture.iata as cityOfDepartureIATA,
       cityOfArrival.id   as cityOfArrivalId,
       cityOfArrival.name as cityOfArrivalName,
       cityOfArrival.iata as cityOfArrivalIATA,
       airportOfDeparture.id   as airportOfDepartureId,
       airportOfDeparture.name as airportOfDepartureName,
       airportOfArrival.id   as airportOfArrivalId,
       airportOfArrival.name as airportOfArrivalName,
       flight.id as flightId,
       airline.id as airlineId,
       timetable.id as timeatableId,
       timetable.departure_date as dateOfDeparture,
       CONCAT(airline.iata, ' ', flight.code, ' (', airportOfDeparture.iata, ' - ', airportOfArrival.iata, ')') as abbr
    FROM country   as countryOfDeparture,
         country   as countryOfArrival,
         city      as cityOfDeparture,
         city      as cityOfArrival,
         airport   as airportOfDeparture,
         airport   as airportOfArrival,
         flight    as flight,
         timetable as timetable,
         airline   as airline
    WHERE ( ( (
        airportOfDeparture.is_published     = 1
        AND countryOfDeparture.is_published = 1
        AND airportOfArrival.is_published   = 1
        AND cityOfArrival.is_published      = 1
        AND countryOfArrival.is_published   = 1
        AND flight.is_published             = 1
        AND cityOfDeparture.is_published    = 1
        AND timetable.is_published          = 1
        AND timetable.departure_date >=NOW()
    )
    AND (
        airportOfDeparture.city_id      =cityOfDeparture.id
        AND airportOfArrival.city_id    =cityOfArrival.id
        AND cityOfArrival.country_id    =countryOfArrival.id
        AND flight.departure_airport_id    =airportOfDeparture.id
        AND flight.destination_airport_id  =airportOfArrival.id
        AND cityOfDeparture.country_id  =countryOfDeparture.id
        AND timetable.flight_id         =flight.id
        AND flight.airline_id           =airline.id
    ) ) )
]);

sub id              { shift->get_column('timeatableId'); }
sub dateOfDeparture { shift->get_column('dateOfDeparture'); }
sub name            { shift->get_column('abbr'); }

sub to_hash {
    my $self = shift;

    return {
        id   => $self->id,
        name => $self->name
    }
}

1;

__END__


