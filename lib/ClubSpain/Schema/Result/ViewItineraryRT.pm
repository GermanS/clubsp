package ClubSpain::Schema::Result::ViewItineraryRT;
use strict;
use warnings;
use utf8;
use parent qw(DBIx::Class::Core);

__PACKAGE__->table_class('DBIx::Class::ResultSource::View');
__PACKAGE__->table('ViewItineraryRT');
__PACKAGE__->result_source_instance->is_virtual(1);
__PACKAGE__->result_source_instance->view_definition(q[
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
        children.parent_id = itinerary.id
    )
    AND (
        airportOfDeparture1.city_id          =cityOfDeparture1.id
        AND airportOfArrival1.city_id        =cityOfArrival1.id
        AND cityOfArrival1.country_id        =countryOfArrival1.id
        AND flight1.departure_airport_id     =airportOfDeparture1.id
        AND flight1.destination_airport_id   =airportOfArrival1.id
        AND cityOfDeparture1.country_id      =countryOfDeparture1.id
        AND timetable1.flight_id             =flight1.id
        AND itinerary.timetable_id           =timetable1.id
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
        children.parent_id = itinerary.id
    )
    AND (
        airportOfDeparture2.city_id          =cityOfDeparture2.id
        AND airportOfArrival2.city_id        =cityOfArrival2.id
        AND cityOfArrival2.country_id        =countryOfArrival2.id
        AND flight2.departure_airport_id     =airportOfDeparture2.id
        AND flight2.destination_airport_id   =airportOfArrival2.id
        AND cityOfDeparture2.country_id      =countryOfDeparture2.id
        AND timetable2.flight_id             =flight2.id
        AND children.timetable_id            =timetable2.id
    ) ) )
) as second
WHERE
    itinerary1Id = itinerary2Id AND
    children1Id = children2Id
]);

1;

__END__

SELECT cityOfDeparture1.id   as cityOfDeparture1Id,
       cityOfDeparture1.name as cityOfDeparture1Name,
       cityOfDeparture1.iata as cityOfDeparture1IATA,
       cityOfArrival1.id   as cityOfArrival1Id,
       cityOfArrival1.name as cityOfArrival1Name,
       cityOfArrival1.iata as cityOfArrival1IATA,
       cityOfDeparture2.id   as cityOfDeparture2Id,
       cityOfDeparture2.name as cityOfDeparture2Name,
       cityOfDeparture2.iata as cityOfDeparture2IATA,
       cityOfArrival2.id   as cityOfArrival2Id,
       cityOfArrival2.name as cityOfArrival2Name,
       cityOfArrival2.iata as cityOfArrival2IATA
    FROM itinerary me
        JOIN timetable timetable1 ON timetable1.id = me.timetable_id
        JOIN flight flight1 ON flight1.id = timetable1.flight_id
        JOIN airport departure_airport ON departure_airport.id = flight1.departure_airport_id
        JOIN city cityOfDeparture1 ON cityOfDeparture1.id = departure_airport.city_id
        JOIN country countryOfDeparture1 ON countryOfDeparture1.id = cityOfDeparture1.country_id
        JOIN airport destination_airport ON destination_airport.id = flight1.destination_airport_id
        JOIN city cityOfArrival1 ON cityOfArrival1.id = destination_airport.city_id
        JOIN country countryOfArrival1 ON countryOfArrival1.id = cityOfArrival1.country_id
        LEFT JOIN itinerary children ON children.parent_id = me.id
        LEFT JOIN timetable timetable2 ON timetable2.id = children.timetable_id
        LEFT JOIN flight flight2 ON flight2.id = timetable2.flight_id
        LEFT JOIN airport departure_airport_2 ON departure_airport_2.id = flight2.departure_airport_id
        LEFT JOIN city cityOfDeparture2 ON cityOfDeparture2.id = departure_airport_2.city_id
        LEFT JOIN country countryOfDeparture2 ON countryOfDeparture2.id = cityOfDeparture2.country_id
        LEFT JOIN airport destination_airport_2 ON destination_airport_2.id = flight2.destination_airport_id
        LEFT JOIN city cityOfArrival2 ON cityOfArrival2.id = destination_airport_2.city_id
        LEFT JOIN country countryOfArrival2 ON countryOfArrival2.id = cityOfArrival2.country_id
        WHERE ( (
            timetable1.departure_date >=NOW()
            AND cityOfDeparture1.is_published = 1
            AND cityOfArrival1.is_published = 1
            AND cityOfDeparture2.is_published = 1
            AND cityOfArrival2.is_published = 1
            AND countryOfDeparture1.is_published = 1
            AND countryOfArrival1.is_published = 1
            AND countryOfDeparture2.is_published = 1
            AND countryOfArrival2.is_published = 1
            AND departure_airport.is_published = 1
            AND departure_airport_2.is_published = 1
            AND destination_airport.is_published = 1
            AND destination_airport_2.is_published = 1
            AND flight1.is_published = 1
            AND flight2.is_published = 1
            AND me.is_published = 1
            AND timetable1.is_published = 1
            AND timetable2.is_published = 1
        ) )
        GROUP BY cityOfDeparture1Id, cityOfArrival1Id, cityOfDeparture2Id, cityOfArrival2Id



SELECT cityOfDeparture1.id   as cityOfDeparture1Id,
       cityOfDeparture1.name as cityOfDeparture1Name,
       cityOfDeparture1.iata as cityOfDeparture1IATA,
       cityOfArrival1.id   as cityOfArrival1Id,
       cityOfArrival1.name as cityOfArrival1Name,
       cityOfArrival1.iata as cityOfArrival1IATA,
       cityOfDeparture2.id   as cityOfDeparture2Id,
       cityOfDeparture2.name as cityOfDeparture2Name,
       cityOfDeparture2.iata as cityOfDeparture2IATA,
       cityOfArrival2.id   as cityOfArrival2Id,
       cityOfArrival2.name as cityOfArrival2Name,
       cityOfArrival2.iata as cityOfArrival2IATA
    FROM country   as countryOfDeparture1,
         country   as countryOfArrival1,
         city      as cityOfDeparture1,
         city      as cityOfArrival1,
         airport   as airportOfDeparture1,
         airport   as airportOfArrival1,
         flight    as flight1,
         timetable as timetable1,
         country   as countryOfDeparture2,
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
        AND airportOfDeparture2.is_published = 1
        AND countryOfDeparture2.is_published = 1
        AND airportOfArrival2.is_published   = 1
        AND cityOfArrival2.is_published      = 1
        AND countryOfArrival2.is_published   = 1
        AND flight2.is_published             = 1
        AND cityOfDeparture2.is_published    = 1
        AND timetable2.is_published          = 1
    )
    AND (
        children.parent_id = itinerary.id
    )
    AND (
        airportOfDeparture1.city_id          =cityOfDeparture1.id
        AND airportOfArrival1.city_id        =cityOfArrival1.id
        AND cityOfArrival1.country_id        =countryOfArrival1.id
        AND flight1.departure_airport_id     =airportOfDeparture1.id
        AND flight1.destination_airport_id   =airportOfArrival1.id
        AND cityOfDeparture1.country_id      =countryOfDeparture1.id
        AND timetable1.flight_id             =flight1.id
        AND itinerary.timetable_id           =timetable1.id
    )
    AND (
        airportOfDeparture2.city_id          =cityOfDeparture2.id
        AND airportOfArrival2.city_id        =cityOfArrival2.id
        AND cityOfArrival2.country_id        =countryOfArrival2.id
        AND flight2.departure_airport_id     =airportOfDeparture2.id
        AND flight2.destination_airport_id   =airportOfArrival2.id
        AND cityOfDeparture2.country_id      =countryOfDeparture2.id
        AND timetable2.flight_id             =flight2.id
        AND children.timetable_id            =timetable2.id
    ) ) )

