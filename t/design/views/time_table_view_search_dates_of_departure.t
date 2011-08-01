use Test::More tests => 23;
use strict;
use warnings;
use DateTime;
use_ok('ClubSpain::Model::TimeTable');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();
my @date = ClubSpain::Test->three_saturdays_ahead();

sub request {
    my %params = @_;
    return ClubSpain::Model::TimeTable->searchDatesOfDeparture(%params);
}

sub request2 {
    my %params = @_;
    $schema->resultset('ViewTimeTable')->searchDatesOfDeparture(%params);
}

#search MOV -> BCN
{
    {
        my $iterator = request(cityOfDeparture => 1, cityOfArrival => 2);
        is($iterator->count, 3, 'got three dates');

        my $first = $iterator->next();
        is($first->departure_date, $date[0]->ymd, 'got the first departure date');

        my $second = $iterator->next();
        is($second->departure_date, $date[1]->ymd, 'got the second departure date');

        my $third = $iterator->next();
        is($third->departure_date, $date[2]->ymd, 'got the third departure date');
    }

    #startDate = $date[1]
    {
        my $iterator = request(cityOfDeparture => 1, cityOfArrival => 2, startDate => $date[1]->ymd);
        is($iterator->count, 1, 'got one date');

        my $first = $iterator->next();
        is($first->departure_date, $date[2]->ymd, 'got the first departure date');
    }

    {
        my $iterator = request2(cityOfDeparture => 1, cityOfArrival => 2);
        is($iterator->count, 3, 'got three dates');

        my $first = $iterator->next();
        is($first->departure_date, $date[0]->ymd, 'got the first departure date');

        my $second = $iterator->next();
        is($second->departure_date, $date[1]->ymd, 'got the second departure date');

        my $third = $iterator->next();
        is($third->departure_date, $date[2]->ymd, 'got the third departure date');
    }

    #startDate = $date[1]
    {
        my $iterator = request2(cityOfDeparture => 1, cityOfArrival => 2, startDate => $date[1]->ymd);
        is($iterator->count, 1, 'got one date');

        my $first = $iterator->next();
        is($first->departure_date, $date[2]->ymd, 'got the first departure date');
    }
}

#set country.is_published to 0
{
    my $russia = $schema->resultset('Country')->search({ id => 1 });
    $russia->update({ is_published => 0 });

    {
        my $iterator = request(cityOfDeparture => 1, cityOfArrival => 2);
        is($iterator->count, 0, 'got nothing');
    }
    {
        my $iterator = request2(cityOfDeparture => 1, cityOfArrival => 2);
        is($iterator->count, 0, 'got nothing');
    }

    $russia->update({ is_published => 1 });
}

#set city.is_published to 0
{
    my $mov = $schema->resultset('City')->search({ id => 1 });
    $mov->update({ is_published => 0 });

    {
        my $iterator = request(cityOfDeparture => 1, cityOfArrival => 2);
        is($iterator->count, 0, 'got nothing');
    }
    {
        my $iterator = request2(cityOfDeparture => 1, cityOfArrival => 2);
        is($iterator->count, 0, 'got nothing');
    }

    $mov->update({ is_published => 1 });
}

#set airport.is_published to 0
{
    my $dme = $schema->resultset('Airport')->search({ id => 1 });
    $dme->update({ is_published => 0 });

    {
        my $iterator = request(cityOfDeparture => 1, cityOfArrival => 2);
        is($iterator->count, 0, 'got nothing');
    }
    {
        my $iterator = request2(cityOfDeparture => 1, cityOfArrival => 2);
        is($iterator->count, 0, 'got nothing');
    }

    $dme->update({ is_published => 1 });
}

#set flight.is_published to 0
{
    my $NN331 = $schema->resultset('Flight')->search({ id => 1 });
    $NN331->update({ is_published => 0 });

    {
        my $iterator = request(cityOfDeparture => 1, cityOfArrival => 2);
        is($iterator->count, 0, 'got nothing');
    }
    {
        my $iterator = request2(cityOfDeparture => 1, cityOfArrival => 2);
        is($iterator->count, 0, 'got nothing');
    }

    $NN331->update({ is_published => 1 });
}

#set timetable.is_published to 0
{
    my @DME_BCN = $schema->resultset('TimeTable')->search({ flight_id => 1 });
    $_->update({ is_published => 0 })
        for (@DME_BCN);

    {
        my $iterator = request(cityOfDeparture => 1, cityOfArrival => 2);
        is($iterator->count, 0, 'got nothing');
    }
    {
        my $iterator = request2(cityOfDeparture => 1, cityOfArrival => 2);
        is($iterator->count, 0, 'got nothing');
    }

    $_->update({ is_published => 1 })
        for (@DME_BCN);
}

