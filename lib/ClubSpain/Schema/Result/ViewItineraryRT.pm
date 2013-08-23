package ClubSpain::Schema::Result::ViewItineraryRT;

use strict;
use warnings;
use utf8;

use parent qw(DBIx::Class::Core);

__PACKAGE__ -> table_class( 'DBIx::Class::ResultSource::View' );
__PACKAGE__ -> table( 'ViewItineraryRT' );
__PACKAGE__ -> result_source_instance -> is_virtual(1);
__PACKAGE__ -> result_source_instance -> view_definition(q[
SELECT * FROM
(
SELECT cityOfDeparture1.id   as cityOfDeparture1Id,
       cityOfDeparture1.name as cityOfDeparture1Name,
       cityOfDeparture1.iata as cityOfDeparture1IATA,
       cityOfArrival1.id   as cityOfArrival1Id,
       cityOfArrival1.name as cityOfArrival1Name,
       cityOfArrival1.iata as cityOfArrival1IATA,
       timetable1.departure_date as dateOfDeparture1,
       itinerary.id as itinerary1Id,
       children.id  as children1Id
    FROM country   as countryOfDeparture1,
         country   as countryOfArrival1,
         city      as cityOfDeparture1,
         city      as cityOfArrival1,
         airport   as airportOfDeparture1,
         airport   as airportOfArrival1,
         flight    as flight1,
         timetable as timetable1,
         itinerary as itinerary,
         itinerary as children
    WHERE ( ( (
        airportOfDeparture1.is_published     = 1
        AND countryOfDeparture1.is_published = 1
        AND airportOfArrival1.is_published   = 1
        AND cityOfArrival1.is_published      = 1
        AND countryOfArrival1.is_published   = 1
        AND flight1.is_published             = 1
        AND cityOfDeparture1.is_published    = 1
        AND timetable1.is_published          = 1
        AND timetable1.departure_date >=NOW()
        AND itinerary.is_published          = 1
        AND itinerary.parent_id             = 0
    )
    AND (
        itinerary.id = children.parent_id
    )
    AND (
        timetable1.id                   = itinerary.timetable_id
        AND flight1.id                  = timetable1.flight_id
        AND (
            airportOfDeparture1.id      = flight1.departure_airport_id
            AND airportOfArrival1.id    = flight1.destination_airport_id
        )
        AND (
            cityOfDeparture1.id         = airportOfDeparture1.city_id
            AND cityOfArrival1.id       = airportOfArrival1.city_id
        )
        AND (
            countryOfDeparture1.id      = cityOfDeparture1.country_id
            AND countryOfArrival1.id        = cityOfArrival1.country_id
        )
    ) ) )
) as first,

(
SELECT cityOfDeparture2.id   as cityOfDeparture2Id,
       cityOfDeparture2.name as cityOfDeparture2Name,
       cityOfDeparture2.iata as cityOfDeparture2IATA,
       cityOfArrival2.id   as cityOfArrival2Id,
       cityOfArrival2.name as cityOfArrival2Name,
       cityOfArrival2.iata as cityOfArrival2IATA,
       timetable2.departure_date as dateOfDeparture2,
       itinerary.id as itinerary2Id,
       children.id  as children2Id
    FROM country   as countryOfDeparture2,
         country   as countryOfArrival2,
         city      as cityOfDeparture2,
         city      as cityOfArrival2,
         airport   as airportOfDeparture2,
         airport   as airportOfArrival2,
         flight    as flight2,
         timetable as timetable2,
         itinerary as itinerary,
         itinerary as children
    WHERE ( ( (
        airportOfDeparture2.is_published     = 1
        AND countryOfDeparture2.is_published = 1
        AND airportOfArrival2.is_published   = 1
        AND cityOfArrival2.is_published      = 1
        AND countryOfArrival2.is_published   = 1
        AND flight2.is_published             = 1
        AND cityOfDeparture2.is_published    = 1
        AND timetable2.is_published          = 1
        AND timetable2.departure_date >=NOW()
        AND itinerary.is_published          = 1
        AND itinerary.parent_id             = 0
    )
    AND (
        itinerary.id = children.parent_id
    )
    AND (
        timetable2.id                   = children.timetable_id
        AND flight2.id                  = timetable2.flight_id
        AND (
            airportOfArrival2.id        = flight2.destination_airport_id
            AND airportOfDeparture2.id  = flight2.departure_airport_id
        )
        AND (
            cityOfArrival2.id           = airportOfArrival2.city_id
            AND cityOfDeparture2.id     = airportOfDeparture2.city_id
        )
        AND (
            countryOfDeparture2.id      = cityOfDeparture2.country_id
            AND countryOfArrival2.id    = cityOfArrival2.country_id
        )
    ) ) )
) as second
WHERE
    itinerary1Id = itinerary2Id AND
    children1Id = children2Id
]);

1;

__END__