use Test::More tests => 12;
use strict;
use warnings;
use lib qw(t/lib);
use ClubSpain::Test;
my $schema = ClubSpain::Test->init_schema();


my $MOW = $schema->resultset('City')->search({ id => 1 })->single;
sub is_MOW {
    my $mow = shift;

    is($mow->id, $MOW->id, 'got id');
    is($mow->iata, $MOW->iata, 'got iata code');
    is($mow->name, $MOW->name, 'got Moscow');
}

my $BCN = $schema->resultset('City')->search({ id => 2 })->single;
sub is_BCN {
    my $bcn = shift;

    is($bcn->id, $BCN->id, 'got id');
    is($bcn->iata, $BCN->iata, 'got iata code');
    is($bcn->name, $BCN->name, 'got Barcelona');
}

sub request {
    return $schema->resultset('ViewItineraryRT')->searchCitiesOfDeparture1();
}


{
    my $iterator = request();

    is($iterator->count, 1, 'got one city of departure');
    &is_MOW($iterator->next);
}

#set russia.is_published to 0
{

    my $ru = $schema->resultset('Country')->search({ id => 1 });
    $ru->update({ is_published => 0 });

    my $iterator = request();
    is($iterator->count, 0, 'got nothing');

    $ru->update({ is_published => 1 });
}

#set espana.is_piblished to 0
{
    my $es = $schema->resultset('Country')->search({ id => 2 });
    $es->update({ is_published => 0 });

    my $iterator = request();
    is($iterator->count, 0, 'got nothing');

    $es->update({ is_published => 1 });
}

#set moscow.is_pblished to 0
{
    $MOW->update({ is_published => 0 });

    my $iterator = request();
    is($iterator->count, 0, 'got nothing');

    $MOW->update({ is_published => 1 });
}

#set barcelona.is_published to 0
{
    $BCN->update({ is_published => 0 });

    my $iterator = request();
    is($iterator->count, 0, 'got nothing');

    $BCN->update({ is_published => 1 });
}


#set DME.is_published to 0
{
    my $dme = $schema->resultset('Airport')->search({ id => 1 })->single();
    $dme->update({ is_published => 0 });

    my $iterator = request();
    is($iterator->count, 0, 'got nothing');

    $dme->update({ is_published => 1 });
}

#set BCN.is_published to 0
{
    my $bcn = $schema->resultset('Airport')->search({ id => 4 })->single();
    $bcn->update({ is_published => 0 });

    my $iterator = request();
    is($iterator->count, 0, 'got nothing');

    $bcn->update({ is_published => 1 });
}

#set nn331.is_published to 0
{
    my $NN331 = $schema->resultset('Flight')->search({ id => 1 });
    $NN331->update({ is_published => 0 });

    my $iterator = request();
    is($iterator->count, 0, 'got nothing');

    $NN331->update({ is_published => 1 });
}

#set timetable.is_published to 0
{
    my @NN332_BCN_DME = $schema->resultset('TimeTable')->search({ flight_id => 2 });
    for my $timetable (@NN332_BCN_DME) {
        $timetable->update({ is_published => 0 });
    }

    my $iterator = request();
    is($iterator->count, 0, 'got nothing');

    for my $timetable (@NN332_BCN_DME) {
        $timetable->update({ is_published => 1 });
    }
}

#set itinerary.is_published to 0
{
    my @NN331_DME_BCN = $schema->resultset('TimeTable')->search({ flight_id => 1 });
    for my $timetable (@NN331_DME_BCN) {
        my $itineraries = $timetable->itineraries();
        $itineraries->update({ is_published => 0 });
    }

    my $iterator = request();
    is($iterator->count, 0, 'got nothing');

    for my $timetable (@NN331_DME_BCN) {
        my $itineraries = $timetable->itineraries();
        $itineraries->update({ is_published => 0 });
    }
}
