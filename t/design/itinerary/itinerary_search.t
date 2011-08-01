use Test::More tests => 49;
use strict;
use warnings;
use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();
my @date   = ClubSpain::Test->three_saturdays_ahead();

my $MOW = $schema->resultset('City')->search({ id => 1 })->single;
my $BCN = $schema->resultset('City')->search({ id => 2 })->single;

my $Y = $schema->resultset('FareClass')->search({ id => 1 })->single;
my $C = $schema->resultset('FareClass')->search({ id => 2 })->single;

my $timetable1 = $schema->resultset('ViewTimeTable')->searchTimetable(
    dateOfDeparture => $date[0]->ymd,
    cityOfDeparture => $MOW->id,
    cityOfArrival   => $BCN->id,
)->single;

my $timetable2 = $schema->resultset('ViewTimeTable')->searchTimetable(
    cityOfDeparture => $BCN->id,
    cityOfArrival   => $MOW->id,
    dateOfDeparture => $date[1]->ymd
)->single;

use_ok('ClubSpain::Model::Itinerary');

#search for one way flight next sat. MOV->BCN
{
    my $iterator = ClubSpain::Model::Itinerary->searchItinerary($timetable1->id);

    is($iterator->count, '2', 'got 2 ow itineraries');

    ### the first itinerary
    my $MOW_BCN_Y = $iterator->next();
    isa_ok($MOW_BCN_Y, 'ClubSpain::Schema::Result::Itinerary');
    is($MOW_BCN_Y->timetable->departure_date, $date[0]->ymd, 'got date of departure');
    is($MOW_BCN_Y->fare_class_id, $Y->id, 'got Y class');
    is($MOW_BCN_Y->parent_id, 0, 'got now other routes');
    is($MOW_BCN_Y->timetable->flight->departure_airport->city->id, $MOW->id,
        'got city of departure'
    );
    is($MOW_BCN_Y->timetable->flight->destination_airport->city->id, $BCN->id,
        'got city of arrival'
    );
    is($MOW_BCN_Y->cost,  175, 'got cost');
    is($MOW_BCN_Y->total, 175, 'got total');

    ### the second itinnerary
    my $MOW_BCN_C = $iterator->next();
    isa_ok($MOW_BCN_C, 'ClubSpain::Schema::Result::Itinerary');
    is($MOW_BCN_C->timetable->departure_date, $date[0]->ymd, 'got date of departure');
    is($MOW_BCN_C->fare_class_id, $C->id, 'got C class');
    is($MOW_BCN_C->parent_id, 0, 'got now other routes');
    is($MOW_BCN_C->timetable->flight->departure_airport->city->id, $MOW->id,
        'got city of departure'
    );
    is($MOW_BCN_C->timetable->flight->destination_airport->city->id, $BCN->id,
        'got city of arrival'
    );
    is($MOW_BCN_C->cost,  250, 'got cost');
    is($MOW_BCN_C->total, 250, 'got total');
}

#search rt flights for MOW->BCN->MOW
{
    my $iterator = ClubSpain::Model::Itinerary->searchItinerary($timetable1->id, $timetable2->id);
    is($iterator->count, '2', 'got 1 rt itineraries');

    {
        my $MOW_BCN_MOW_Y1 = $iterator->next();

        isa_ok($MOW_BCN_MOW_Y1, 'ClubSpain::Schema::Result::Itinerary');
        is($MOW_BCN_MOW_Y1->timetable->id, $timetable1->id, 'got timetable1');
        is($MOW_BCN_MOW_Y1->fare_class->id, $Y->id, 'got fare class');
        is($MOW_BCN_MOW_Y1->timetable->flight->departure_airport->city->id, $MOW->id, 'got city of departure');
        is($MOW_BCN_MOW_Y1->timetable->flight->destination_airport->city->id, $BCN->id, 'got city of arrival');
        is($MOW_BCN_MOW_Y1->timetable->departure_date, $date[0]->ymd, 'got date of departure');
        is($MOW_BCN_MOW_Y1->cost, 150, 'got segment cost 150');

        my $MOW_BCN_MOW_Y2 = $MOW_BCN_MOW_Y1->next_route();

        isa_ok($MOW_BCN_MOW_Y2, 'ClubSpain::Schema::Result::Itinerary');
        is($MOW_BCN_MOW_Y2->timetable->id, $timetable2->id, 'got timetable2');
        is($MOW_BCN_MOW_Y2->fare_class->id, $Y->id, 'got fare class');
        is($MOW_BCN_MOW_Y2->timetable->flight->departure_airport->city->id, $BCN->id, 'got city of departure');
        is($MOW_BCN_MOW_Y2->timetable->flight->destination_airport->city->id, $MOW->id, 'got city of arrival');
        is($MOW_BCN_MOW_Y2->timetable->departure_date, $date[1]->ymd, 'got date of departure');
        is($MOW_BCN_MOW_Y2->cost, 160, 'got segment cost 160');

        is($MOW_BCN_MOW_Y1->total, 310, 'got total NN331-332 Y MOW-BCN-MOW');
    }

    {
        my $MOW_BCN_MOW_C1 = $iterator->next();
        isa_ok($MOW_BCN_MOW_C1, 'ClubSpain::Schema::Result::Itinerary');
        is($MOW_BCN_MOW_C1->timetable->id, $timetable1->id, 'got timetable1');
        is($MOW_BCN_MOW_C1->fare_class->id, $C->id, 'got fare class');
        is($MOW_BCN_MOW_C1->timetable->flight->departure_airport->city->id, $MOW->id, 'got city of departure');
        is($MOW_BCN_MOW_C1->timetable->flight->destination_airport->city->id, $BCN->id, 'got city of arrival');
        is($MOW_BCN_MOW_C1->timetable->departure_date, $date[0]->ymd, 'got date of departure');
        is($MOW_BCN_MOW_C1->cost, 250, 'got segment cost 250');

        my $MOW_BCN_MOW_C2 = $MOW_BCN_MOW_C1->next_route();

        isa_ok($MOW_BCN_MOW_C2, 'ClubSpain::Schema::Result::Itinerary');
        is($MOW_BCN_MOW_C2->timetable->id, $timetable2->id, 'got timetable2');
        is($MOW_BCN_MOW_C2->fare_class->id, $C->id, 'got fare class');
        is($MOW_BCN_MOW_C2->timetable->flight->departure_airport->city->id, $BCN->id, 'got city of departure');
        is($MOW_BCN_MOW_C2->timetable->flight->destination_airport->city->id, $MOW->id, 'got city of arrival');
        is($MOW_BCN_MOW_C2->timetable->departure_date, $date[1]->ymd, 'got date of departure');
        is($MOW_BCN_MOW_C2->cost, 350, 'got segment cost 350');

        is($MOW_BCN_MOW_C1->total(), 600, 'got total 600 NN331-332 C MOW-BCN-MOW');
    }
}
