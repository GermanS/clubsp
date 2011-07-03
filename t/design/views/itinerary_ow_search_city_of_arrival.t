use Test::More tests => 69;
use strict;
use warnings;
use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();

use_ok('ClubSpain::Model::City');

my $MOW = $schema->resultset('City')->search({ id => 1 })->single();
my $BCN = $schema->resultset('City')->search({ id => 2 })->single();

sub is_MOW {
    my $mow = shift;

    is($mow->id, $MOW->id, 'got id');
    is($mow->iata, $MOW->iata, 'got iata code');
    is($mow->name, $MOW->name, 'got Moscow');
}

sub is_BCN {
    my $bcn = shift;

    is($bcn->id, $BCN->id, 'got id');
    is($bcn->iata, $BCN->iata, 'got iata code');
    is($bcn->name, $BCN->name, 'got Barcelona');
}

sub request {
    my %params = @_;

    return $schema->resultset('ViewItineraryOW')->searchCitiesOfArrival(%params);
}

sub request2 {
    my %params = @_;

    return ClubSpain::Model::City->searchCitiesOfArrivalOW(%params);
}

{
    {
        my $iterator = request(cityOfDeparture => $MOW->id );
        is($iterator->count, 1, 'got one city');
        &is_BCN($iterator->next);

        $iterator = request(cityOfDeparture => $BCN->id );
        is($iterator->count, 1, 'got one city');
        &is_MOW($iterator->next);
    }

    {
        my $iterator = request2(cityOfDeparture => $MOW->id );
        is($iterator->count, 1, 'got one city');
        &is_BCN($iterator->next);

        $iterator = request2(cityOfDeparture => $BCN->id );
        is($iterator->count, 1, 'got one city');
        &is_MOW($iterator->next);
    }
}

#set spain.is_published to 0
{
    my $es = $schema->resultset('Country')->search({ id => 1 })->single();
    $es->update({ is_published => 0 });

    {
        my $iterator = request(cityOfDeparture => $MOW->id );
        is($iterator->count, 0, 'got nothing');

        $iterator = request(cityOfDeparture => $BCN->id );
        is($iterator->count, 0, 'got nothing');
    }

    {
        my $iterator = request2(cityOfDeparture => $MOW->id );
        is($iterator->count, 0, 'got nothing');

        $iterator = request2(cityOfDeparture => $BCN->id );
        is($iterator->count, 0, 'got nothing');
    }

    $es->update({ is_published => 1 });
}

#set barcelona.is_published to 0
{
    $BCN->update({ is_published => 0 });

    {
        my $iterator = request(cityOfDeparture => $MOW->id );
        is($iterator->count, 0, 'got nothing');

        $iterator = request(cityOfDeparture => $BCN->id );
        is($iterator->count, 0, 'got nothing');
    }

    {
        my $iterator = request2(cityOfDeparture => $MOW->id );
        is($iterator->count, 0, 'got nothing');

        $iterator = request2(cityOfDeparture => $BCN->id );
        is($iterator->count, 0, 'got nothing');
    }

    $BCN->update({ is_published => 1 });
}

#set DME is_published to 0
{
    my $dme = $schema->resultset('Airport')->search({ id => 1 })->single();
    $dme->update({ is_published => 0 });

    {
        my $iterator = request(cityOfDeparture => $MOW->id );
        is($iterator->count, 0, 'got nothing');

        $iterator = request(cityOfDeparture => $BCN->id );
        is($iterator->count, 0, 'got nothing');
    }

    {
        my $iterator = request2(cityOfDeparture => $MOW->id );
        is($iterator->count, 0, 'got nothing');

        $iterator = request2(cityOfDeparture => $BCN->id );
        is($iterator->count, 0, 'got nothing');
    }

    $dme->update({ is_published => 1 });
}

#set NN331 is_published to 0
{
    my $nn331 = $schema->resultset('Flight')->search({ id => 1 })->single();
    $nn331->update({ is_published => 0 });

    {
        my $iterator = request(cityOfDeparture => $MOW->id );
        is($iterator->count, 0, 'got nothing');

        $iterator = request(cityOfDeparture => $BCN->id );
        is($iterator->count, 1, 'got one city');
        &is_MOW($iterator->next);
    }

    {
        my $iterator = request2(cityOfDeparture => $MOW->id );
        is($iterator->count, 0, 'got nothing');

        $iterator = request2(cityOfDeparture => $BCN->id );
        is($iterator->count, 1, 'got one city');
        &is_MOW($iterator->next);
    }

    $nn331->update({ is_published => 1 });
}

#set nn332 is_published to 0
{
    my $nn332 = $schema->resultset('Flight')->search({ id => 2 })->single();
    $nn332->update({ is_published => 0 });

    {
        my $iterator = request(cityOfDeparture => $MOW->id );
        is($iterator->count, 1, 'got one city');
        &is_BCN($iterator->next);

        $iterator = request(cityOfDeparture => $BCN->id );
        is($iterator->count, 0, 'got one nothing');
    }

    {
        my $iterator = request2(cityOfDeparture => $MOW->id );
        is($iterator->count, 1, 'got one city');
        &is_BCN($iterator->next);

        $iterator = request2(cityOfDeparture => $BCN->id );
        is($iterator->count, 0, 'got one nothing');
    }

    $nn332->update({ is_published => 1 });
}

#set nn331 timetable to 0
{
    my $nn331 = $schema->resultset('Flight')->search({ id => 1 })->single;
    my $timetable = $nn331->time_tables();
    $timetable->update({ is_published => 0 });

    {
        my $iterator = request(cityOfDeparture => $MOW->id );
        is($iterator->count, 0, 'got nothing');

        $iterator = request(cityOfDeparture => $BCN->id );
        is($iterator->count, 1, 'got one city');
        &is_MOW($iterator->next);
    }

    {
        my $iterator = request2(cityOfDeparture => $MOW->id );
        is($iterator->count, 0, 'got nothing');

        $iterator = request2(cityOfDeparture => $BCN->id );
        is($iterator->count, 1, 'got one city');
        &is_MOW($iterator->next);
    }

    $timetable->update({ is_published => 1 });
}

#set nn332 itinerary to 0
{
    my $nn332 = $schema->resultset('Flight')->search({ id => 2 })->single;
    my $timetable = $nn332->time_tables;
    while (my $schedule = $timetable->next) {
        my $itineraries = $schedule->itineraries;
        $itineraries->update({ is_published => 0 });
    }

    {
        my $iterator = request(cityOfDeparture => $MOW->id );
        is($iterator->count, 1, 'got one city');
        &is_BCN($iterator->next);

        $iterator = request(cityOfDeparture => $BCN->id );
        is($iterator->count, 0, 'got nothing');
    }

    {
        my $iterator = request2(cityOfDeparture => $MOW->id );
        is($iterator->count, 1, 'got one city');
        &is_BCN($iterator->next);

        $iterator = request2(cityOfDeparture => $BCN->id );
        is($iterator->count, 0, 'got nothing');
    }

    $timetable = $nn332->time_tables;
    while (my $schedule = $timetable->next) {
        my $itineraries = $schedule->itineraries;
        $itineraries->update({ is_published => 0 });
    }
}
