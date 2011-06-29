use Test::More tests => 23;
use strict;
use warnings;

use lib qw(t/lib);

use ClubSpain::Test;
my $schema = ClubSpain::Test->init_schema();

use_ok('ClubSpain::Model::City');

my $MOW = $schema->resultset('City')->search({ id => 1 })->single;
sub check_MOW {
    my $mow = shift;

    is($mow->id, $MOW->id, 'got id');
    is($mow->iata, $MOW->iata, 'got iata code');
    is($mow->name, $MOW->name, 'got Moscow');
}

my $BCN = $schema->resultset('City')->search({ id => 2 })->single;
sub check_BCN {
    my $bcn = shift;

    is($bcn->id, $BCN->id, 'got id');
    is($bcn->iata, $BCN->iata, 'got iata code');
    is($bcn->name, $BCN->name, 'got Barcelona');
}


{
    my $iterator =
        ClubSpain::Model::City->searchCitiesOfDepartureInOWItinerary();

    is($iterator->count, 2, 'got 2 cities of departure');
    &check_MOW($iterator->next);
    &check_BCN($iterator->next);
}

#set russia.is_published to 1
{
    my $RU = $schema->resultset('Country')->search({ id => 1 })->single();
    $RU->update({ is_published => 0 });

    my $iterator =
        ClubSpain::Model::City->searchCitiesOfDepartureInOWItinerary();
    is($iterator->count, 0, 'got nothing');

    $RU->update({ is_published => 1 });

}

#set barcelona.is_published to 0
{
    $BCN->update({ is_published => 0 });

    my $iterator =
        ClubSpain::Model::City->searchCitiesOfDepartureInOWItinerary();
    is($iterator->count, 0, 'got nothing');

    $BCN->update({ is_published => 1 });
}

#set DME.is_published to 0
{
    my $dme = $schema->resultset('Airport')->search({ id => 1 })->single();
    $dme->update({ is_published => 0 });

    my $iterator =
        ClubSpain::Model::City->searchCitiesOfDepartureInOWItinerary();
    is($iterator->count, 0, 'got nothing');

    $dme->update({ is_published => 1 });
}

#set NN332 is_published to 0
{
    my $nn332 = $schema->resultset('Flight')->search({ id => 2 })->single;
    $nn332->update({ is_published => 0 });

    my $iterator =
        ClubSpain::Model::City->searchCitiesOfDepartureInOWItinerary();
    is($iterator->count, 1, 'got one city');

    &check_MOW($iterator->next);

    $nn332->update({ is_published => 1 });
}

#set NN331 timetable to 0
{
    my $nn331 = $schema->resultset('Flight')->search({ id => 1 })->single;
    my $timetable = $nn331->time_tables();
    $timetable->update({ is_published => 0 });

    my $iterator =
        ClubSpain::Model::City->searchCitiesOfDepartureInOWItinerary();
    is($iterator->count, 1, 'got one city');

    &check_BCN($iterator->next);

    $timetable->update({ is_published => 1 });
}

#set itinerary.is_published to 0 OW flight nn332
{
    my $nn332 = $schema->resultset('Flight')->search({ id => 2 })->single();
    my $timetable = $nn332->time_tables;
    while (my $schedule = $timetable->next) {
        my $itineraries = $schedule->itineraries;
        $itineraries->update({ is_published => 0 });
    }



    my $iterator =
        ClubSpain::Model::City->searchCitiesOfDepartureInOWItinerary();
    is($iterator->count, 1, 'got one city');
    &check_MOW($iterator->next);



    $timetable = $nn332->time_tables;
    while (my $schedule = $timetable->next) {
        my $itineraries = $schedule->itineraries;
        $itineraries->update({ is_published => 0 });
    }
}




