use Test::More tests => 9;
use strict;
use warnings;

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

my @saturday = ClubSpain::Test->three_saturdays_ahead();

use_ok('ClubSpain::Model::Flight');

{
    my $iterator = ClubSpain::Model::Flight->searchFlightsInTimetable(
        cityOfDeparture => 1,
        cityOfArrival   => 2,
        dateOfDeparture => $saturday[0]->ymd,
    );

    is($iterator->count, 1, 'got one flight');

    my $NN331 = $iterator->next();
    is($NN331->id, 1, 'got id');
    is($NN331->code, 331, 'got code');
}

#set country.is_published to 0
{
    my $russia = $helper->schema->resultset('Country')->search({ id => 1 });
    $russia->update({ is_published => 0 });

    my $iterator = ClubSpain::Model::Flight->searchFlightsInTimetable(
        cityOfDeparture => 1,
        cityOfArrival   => 2,
        dateOfDeparture => $saturday[0]->ymd
    );
    is($iterator->count, 0, 'got nothing');

    $russia->update({ is_published => 1 });
}

#set city.is_published to 0
{
    my $mov = $helper->schema->resultset('City')->search({ id => 1 });
    $mov->update({ is_published => 0 });

    my $iterator = ClubSpain::Model::Flight->searchFlightsInTimetable(
        cityOfDeparture => 1,
        cityOfArrival   => 2,
        dateOfDeparture => $saturday[0]->ymd
    );
    is($iterator->count, 0, 'got nothing');

    $mov->update({ is_published => 1 });
}

#set airport.is_published to 0
{
    my $dme = $helper->schema->resultset('Airport')->search({ id => 1 });
    $dme->update({ is_published => 0 });

    my $iterator = ClubSpain::Model::Flight->searchFlightsInTimetable(
        cityOfDeparture => 1,
        cityOfArrival   => 2,
        dateOfDeparture => $saturday[0]->ymd
    );
    is($iterator->count, 0, 'got nothing');

    $dme->update({ is_published => 1 });
}

#set flight.is_published to 0
{
    my $NN331 = $helper->schema->resultset('Flight')->search({ id => 1 });
    $NN331->update({ is_published => 0 });

    my $iterator = ClubSpain::Model::Flight->searchFlightsInTimetable(
        cityOfDeparture => 1,
        cityOfArrival   => 2,
        dateOfDeparture => $saturday[0]->ymd
    );
    is($iterator->count, 0, 'got nothing');

    $NN331->update({ is_published => 1 });
}

#set timetable.is_published to 0
{
    my @DME_BCN = $helper->schema->resultset('TimeTable')->search({
        departure_date => $saturday[0]->ymd
    });

    $_->update({ is_published => 0 })
        for (@DME_BCN);

    my $iterator = ClubSpain::Model::Flight->searchFlightsInTimetable(
        cityOfDeparture => 1,
        cityOfArrival   => 2,
        dateOfDeparture => $saturday[0]->ymd
    );
    is($iterator->count, 0, 'got nothing');

    $_->update({ is_published => 1 })
        for (@DME_BCN);
}
