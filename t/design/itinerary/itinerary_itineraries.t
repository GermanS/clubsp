use Test::More tests => 58;
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

use_ok('ClubSpain::Model::Itinerary');

# search all OW MOW - BCN
{
    my $iterator = ClubSpain::Model::Itinerary->itineraries({
        cityOfDeparture => $MOW->id,
        cityOfArrival   => $BCN->id
    });

    is($iterator->count, 2, 'got two OW tickets');

    ###
    ### MOW_BCN_Y
    ###
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

    ###
    ### MOW_BCN_C
    ###
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

#search all RT MOW->BCN
{
    my $iterator = ClubSpain::Model::Itinerary->itineraries({
        cityOfDeparture => $MOW->id,
        cityOfArrival   => $BCN->id
    }, {
        cityOfDeparture => $BCN->id,
        cityOfArrival   => $MOW->id
    });

    is($iterator->count, 3, 'got three RT tickets');

    #the 1st ticket MOW-BCN-MOW Y date[0]-date[1]
    {
        my $MOW_BCN_MOW_Y1 = $iterator->next();
        isa_ok($MOW_BCN_MOW_Y1, 'ClubSpain::Schema::Result::Itinerary');
        is($MOW_BCN_MOW_Y1->fare_class->id, $Y->id, 'got fare class');
        is($MOW_BCN_MOW_Y1->timetable->flight->departure_airport->city->id, $MOW->id, 'got city of departure');
        is($MOW_BCN_MOW_Y1->timetable->flight->destination_airport->city->id, $BCN->id, 'got city of arrival');
        is($MOW_BCN_MOW_Y1->timetable->departure_date, $date[0]->ymd, 'got date of departure');
        is($MOW_BCN_MOW_Y1->cost, 150, 'got segment cost 150');

        my $MOW_BCN_MOW_Y2 = $MOW_BCN_MOW_Y1->next_route();
        isa_ok($MOW_BCN_MOW_Y2, 'ClubSpain::Schema::Result::Itinerary');
        is($MOW_BCN_MOW_Y2->fare_class->id, $Y->id, 'got fare class');
        is($MOW_BCN_MOW_Y2->timetable->flight->departure_airport->city->id, $BCN->id, 'got city of departure');
        is($MOW_BCN_MOW_Y2->timetable->flight->destination_airport->city->id, $MOW->id, 'got city of arrival');
        is($MOW_BCN_MOW_Y2->timetable->departure_date, $date[1]->ymd, 'got date of departure');
        is($MOW_BCN_MOW_Y2->cost, 160, 'got segment cost 160');

        is($MOW_BCN_MOW_Y1->total, 310, 'got total NN331-332 Y MOW-BCN-MOW date[0]-date[1]');
    }

    #the 3rd ticket MOW-BCN-MOW C date[0] date[1]
    {
        my $MOW_BCN_MOW_C1 = $iterator->next();
        isa_ok($MOW_BCN_MOW_C1, 'ClubSpain::Schema::Result::Itinerary');
        is($MOW_BCN_MOW_C1->fare_class->id, $C->id, 'got fare class');
        is($MOW_BCN_MOW_C1->timetable->flight->departure_airport->city->id, $MOW->id, 'got city of departure');
        is($MOW_BCN_MOW_C1->timetable->flight->destination_airport->city->id, $BCN->id, 'got city of arrival');
        is($MOW_BCN_MOW_C1->timetable->departure_date, $date[0]->ymd, 'got date of departure');
        is($MOW_BCN_MOW_C1->cost, 250, 'got segment cost 150');

        my $MOW_BCN_MOW_C2 = $MOW_BCN_MOW_C1->next_route();
        isa_ok($MOW_BCN_MOW_C2, 'ClubSpain::Schema::Result::Itinerary');
        is($MOW_BCN_MOW_C2->fare_class->id, $C->id, 'got fare class');
        is($MOW_BCN_MOW_C2->timetable->flight->departure_airport->city->id, $BCN->id, 'got city of departure');
        is($MOW_BCN_MOW_C2->timetable->flight->destination_airport->city->id, $MOW->id, 'got city of arrival');
        is($MOW_BCN_MOW_C2->timetable->departure_date, $date[1]->ymd, 'got date of departure');
        is($MOW_BCN_MOW_C2->cost, 350, 'got segment cost 160');

        is($MOW_BCN_MOW_C1->total, 600, 'got total NN331-332 C MOW-BCN-MOW date[0]-date[1]');
    }

    #the 2nd ticket MOW-BCN-MOW Y date[0]-date[2]
    {
        my $MOW_BCN_MOW_Y1 = $iterator->next();
        isa_ok($MOW_BCN_MOW_Y1, 'ClubSpain::Schema::Result::Itinerary');
        is($MOW_BCN_MOW_Y1->fare_class->id, $Y->id, 'got fare class');
        is($MOW_BCN_MOW_Y1->timetable->flight->departure_airport->city->id, $MOW->id, 'got city of departure');
        is($MOW_BCN_MOW_Y1->timetable->flight->destination_airport->city->id, $BCN->id, 'got city of arrival');
        is($MOW_BCN_MOW_Y1->timetable->departure_date, $date[0]->ymd, 'got date of departure');
        is($MOW_BCN_MOW_Y1->cost, 170, 'got segment cost 150');

        my $MOW_BCN_MOW_Y2 = $MOW_BCN_MOW_Y1->next_route();
        isa_ok($MOW_BCN_MOW_Y2, 'ClubSpain::Schema::Result::Itinerary');
        is($MOW_BCN_MOW_Y2->fare_class->id, $Y->id, 'got fare class');
        is($MOW_BCN_MOW_Y2->timetable->flight->departure_airport->city->id, $BCN->id, 'got city of departure');
        is($MOW_BCN_MOW_Y2->timetable->flight->destination_airport->city->id, $MOW->id, 'got city of arrival');
        is($MOW_BCN_MOW_Y2->timetable->departure_date, $date[2]->ymd, 'got date of departure');
        is($MOW_BCN_MOW_Y2->cost, 170, 'got segment cost 160');

        is($MOW_BCN_MOW_Y1->total, 340, 'got total NN331-332 Y MOW-BCN-MOW date[0]-date[2]');
    }
}
