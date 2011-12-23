use Test::More tests => 17;
use strict;
use warnings;
use utf8;
use_ok('ClubSpain::Model::TimeTable');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();
my $MOW = $helper->moscow();

my @dates = ClubSpain::Test->three_saturdays_ahead();

{
    my $iterator = $helper->schema->resultset('TimeTable')->departures();
    is($iterator, undef, 'got nothing');
}

{
    my $iterator = $helper->schema->resultset('TimeTable')->departures(
        cityOfDeparture => $MOW->id
    );

    isa_ok($iterator, 'ClubSpain::Schema::ResultSet::TimeTable');
    is($iterator->count, 3, 'got three flights');

    my $timetable = $iterator->next();
    is($timetable->departure_date, $dates[0]->ymd, 'got the first date of departure');

    $timetable = $iterator->next();
    is($timetable->departure_date, $dates[1]->ymd, 'got the second date of departure');

    $timetable = $iterator->next();
    is($timetable->departure_date, $dates[2]->ymd, 'got the third date of departure');
}

{
    my $iterator = $helper->schema->resultset('TimeTable')->departures(
        cityOfDeparture => $MOW->id,
        duration        => 7,
    );

    isa_ok($iterator, 'ClubSpain::Schema::ResultSet::TimeTable');
    is($iterator->count, 1, 'got one flight from Moscow');

    my $timetable = $iterator->next();

    is($timetable->flight->id, 1, 'got flight id');
    is($timetable->flight->code, 331, 'for flight code');
    is($timetable->flight->airline->iata, 'NN', 'got airline iate code');
    is($timetable->flight->departure_airport->city->name, 'Moscow');
    is($timetable->flight->destination_airport->city->name, 'Barcelona');
    is($timetable->departure_time, '10:00:00', 'got time of departure');
    is($timetable->arrival_time, '12:00:00', 'got time af arrival');
    is($timetable->departure_date, $dates[0]->ymd, 'got departure date');
}
