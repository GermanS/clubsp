use Test::More tests => 13;
use strict;
use warnings;

use lib qw(t/lib);
use ClubSpain::Test;
my $schema = ClubSpain::Test->init_schema();

use_ok('ClubSpain::Model::City');

{
    my $iterator =
        ClubSpain::Model::City->searchCitiesOfArrivalInTimeTable(
            cityOfDeparture => 1,
        );

    is($iterator->count, 1, 'got one city');

    my $bcn = $iterator->next();
    is($bcn->id, 2, 'got id');
    is($bcn->iata, 'BCN', 'got iata code');
    is($bcn->name, 'Barcelona', 'got Barcelona');
}

#set country.is_published to 0
{
    my $spain = $schema->resultset('Country')->search({id => 2});
    $spain->update({ is_published => 0 });

    my $iterator =
        ClubSpain::Model::City->searchCitiesOfArrivalInTimeTable(
            cityOfDeparture => 1,
        );

    is($iterator->count, 0, 'got nothing');

    $spain->update({ is_published => 1 });
}

#set city.is_published to 0
{
    my $bcn = $schema->resultset('City')->search({ id => 2 });
    $bcn->update({ is_published => 0 });

    my $iterator =
        ClubSpain::Model::City->searchCitiesOfArrivalInTimeTable(
            cityOfDeparture => 1,
        );
    is($iterator->count, 0, 'got nothing');

    $bcn->update({ is_published => 1 });
}

#set airport.is_published to 0
{
    my $bcn = $schema->resultset('Airport')->search({ id => 4 });
    $bcn->update({ is_published => 0 });

    my $iterator =
        ClubSpain::Model::City->searchCitiesOfArrivalInTimeTable(
            cityOfDeparture => 1,
        );
    is($iterator->count, 0, 'got nothing');

    $bcn->update({ is_published => 1 });
}

#set flight.is_published to 0
{
    my $NN331 = $schema->resultset('Flight')->search({ id => 1 });
    $NN331->update({ is_published => 0 });

    my $iterator =
        ClubSpain::Model::City->searchCitiesOfArrivalInTimeTable(
            cityOfDeparture => 1,
        );
    is($iterator->count, 0, 'got nothing');

    $NN331->update({ is_published => 1 });
}

#set timetable.is_published to 0
{
    my @NN332_BCN_DME = $schema->resultset('TimeTable')->search({ flight_id => 2 });
    for my $timetable (@NN332_BCN_DME) {
        $timetable->update({ is_published => 0 });
    }

    my $iterator =
        ClubSpain::Model::City->searchCitiesOfArrivalInTimeTable(
            cityOfDeparture => 1,
        );
    is($iterator->count, 1, 'got one city');

    my $bcn = $iterator->next();
    is($bcn->id, 2, 'got id');
    is($bcn->iata, 'BCN', 'got iata code');
    is($bcn->name, 'Barcelona', 'got barcelona');

    for my $timetable (@NN332_BCN_DME) {
        $timetable->update({ is_published => 1 });
    }
}