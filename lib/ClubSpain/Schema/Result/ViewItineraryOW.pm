package ClubSpain::Schema::Result::ViewItineraryOW;

use strict;
use warnings;
use utf8;

use parent qw(DBIx::Class::Core);

__PACKAGE__ -> table_class( 'DBIx::Class::ResultSource::View' );
__PACKAGE__ -> table( 'ViewItineraryOW' );
__PACKAGE__ -> result_source_instance -> is_virtual(1);
__PACKAGE__ -> result_source_instance -> view_definition(q[
SELECT cityOfDeparture.id   as cityOfDepartureId,
       cityOfDeparture.name as cityOfDepartureName,
       cityOfDeparture.iata as cityOfDepartureIATA,
       cityOfArrival.id   as cityOfArrivalId,
       cityOfArrival.name as cityOfArrivalName,
       cityOfArrival.iata as cityOfArrivalIATA,
       timetable.departure_date as dateOfDeparture
    FROM country   as countryOfDeparture,
         country   as countryOfArrival,
         city      as cityOfDeparture,
         city      as cityOfArrival,
         airport   as airportOfDeparture,
         airport   as airportOfArrival,
         flight    as flight,
         timetable as timetable,
         itinerary as itinerary
             LEFT JOIN itinerary as children on children.parent_id = itinerary.id
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
        AND itinerary.is_published          = 1
        AND itinerary.parent_id             = 0
        AND children.id IS NULL
    )
    AND (
        airportOfDeparture.city_id          =cityOfDeparture.id
        AND airportOfArrival.city_id        =cityOfArrival.id
        AND cityOfArrival.country_id        =countryOfArrival.id
        AND flight.departure_airport_id     =airportOfDeparture.id
        AND flight.destination_airport_id   =airportOfArrival.id
        AND cityOfDeparture.country_id      =countryOfDeparture.id
        AND timetable.flight_id             =flight.id
        AND itinerary.timetable_id          =timetable.id
    ) ) )
]);

1;

__END__