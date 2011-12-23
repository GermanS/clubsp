use Test::More tests => 37;
use strict;
use warnings;
use_ok('ClubSpain::Model::TimeTable');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();
my $schema = $helper->schema;

my $MOW = $helper->moscow();
sub is_MOW {
    my $mow = shift;

    is($mow->id, $MOW->id, 'got id: '. $MOW->id);
    is($mow->iata, $MOW->iata, 'got iata code: '. $MOW->iata);
    is($mow->name, $MOW->name, 'got Moscow: ' . $MOW->name);
}

my $BCN = $helper->barcelona();
sub is_BCN {
    my $bcn = shift;

    is($bcn->id, $BCN->id, 'got id: '. $BCN->id);
    is($bcn->iata, $BCN->iata, "got iata code: " . $BCN->iata);
    is($bcn->name, $BCN->name, "got city: " . $BCN->name);
}

sub request {
    return $schema->resultset('ViewTimeTable')->searchCitiesOfDeparture();
}

sub request2 {
    return ClubSpain::Model::TimeTable->searchCitiesOfDeparture();
}

{
    {
        my $iterator = request();

        is($iterator->count, 2, 'got two cities');
        is_MOW($iterator->next);
        is_BCN($iterator->next);
    }
    {
        my $iterator = request2();

        is($iterator->count, 2, 'got two cities');
        is_MOW($iterator->next);
        is_BCN($iterator->next);
    }
}

#set country.is_published to 0
{
    my $spain = $schema->resultset('Country')->search({id => 2});
    $spain->update({ is_published => 0 });

    {
        my $iterator = request();
        is($iterator->count, 0, 'got nothing');
    }
    {
        my $iterator = request2();
        is($iterator->count, 0, 'got nothing');
    }

    $spain->update({ is_published => 1 });
}

#set city.is_published to 0
{
    my $bcn = $schema->resultset('City')->search({ id => 2 });
    $bcn->update({ is_published => 0 });

    {
        my $iterator = request();
        is($iterator->count, 0, 'got nothing');
    }
    {
        my $iterator = request2();
        is($iterator->count, 0, 'got nothing');
    }

    $bcn->update({ is_published => 1 });
}

#set airport.is_published to 0
{
    my $bcn = $schema->resultset('Airport')->search({ id => 4 });
    $bcn->update({ is_published => 0 });

    {
        my $iterator = request();
        is($iterator->count, 0, 'got nothing');
    }
    {
        my $iterator = request2();
        is($iterator->count, 0, 'got nothing');
    }

    $bcn->update({ is_published => 1 });
}

#set flight.is_published to 0
{
    my $NN331 = $schema->resultset('Flight')->search({ id => 1 });
    $NN331->update({ is_published => 0 });

    {
        my $iterator = request();
        is($iterator->count, 1, 'got a city');
        is_BCN($iterator->next);
    }
    {
        my $iterator = request2();
        is($iterator->count, 1, 'got a city');
        is_BCN($iterator->next);
    }

    $NN331->update({ is_published => 1 });
}

#set timetable.is_published to 0
{
    my @NN332_BCN_DME = $schema->resultset('TimeTable')->search({ flight_id => 2 });
    for my $timetable (@NN332_BCN_DME) {
        $timetable->update({ is_published => 0 });
    }

    {
        my $iterator = request();
        is($iterator->count, 1, 'got one city');
        is_MOW($iterator->next);
    }
    {
        my $iterator = request2();
        is($iterator->count, 1, 'got one city');
        is_MOW($iterator->next);
    }

    for my $timetable (@NN332_BCN_DME) {
        $timetable->update({ is_published => 1 });
    }
}
