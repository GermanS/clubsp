use Test::More tests => 32;
use strict;
use warnings;
use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();


my $MOW = $schema->resultset('City')->search({ id => 1 })->single;
sub is_MOW {
    my $mow = shift;

    is($mow->id, $MOW->id, 'got id: '. $MOW->id);
    is($mow->iata, $MOW->iata, 'got iata code: '. $MOW->iata);
    is($mow->name, $MOW->name, 'got Moscow: ' . $MOW->name);
}

my $BCN = $schema->resultset('City')->search({ id => 2 })->single;
sub is_BCN {
    my $bcn = shift;

    is($bcn->id, $BCN->id, 'got id: '. $BCN->id);
    is($bcn->iata, $BCN->iata, "got iata code: " . $BCN->iata);
    is($bcn->name, $BCN->name, "got city: " . $BCN->name);
}

my $AGP = $schema->resultset('City')->search({ id => 3 })->single();
sub is_AGP {
    my $agp = shift;

    is($agp->id, 3, 'got id: ' . $AGP->id);
    is($agp->iata, 'AGP', 'got iata code: '.$AGP->iata);
    is($agp->name, 'Malaga', 'got city:'.$AGP->name);
}

sub request {
    $schema->resultset('ViewFlight')->searchCitiesOfDeparture();
}


{
    my $iterator = request();

    is($iterator->count, 3, 'got three cities');
    is_MOW($iterator->next);
    is_BCN($iterator->next);
    is_AGP($iterator->next);
}

#set country.is_published to 0
{
    my $spain = $schema->resultset('Country')->search({id => 2});
    $spain->update({ is_published => 0 });

    my $iterator = request();

    is($iterator->count, 0, 'got nothing');

    $spain->update({ is_published => 1 });
}

#set city.is_published to 0
{
    my $barcelona = $schema->resultset('City')->search({id => 2});
    $barcelona->update({ is_published => 0 });

    my $iterator = request();

    is($iterator->count, 2, 'got 2 cities');

    is_MOW($iterator->next);
    is_AGP($iterator->next);

    $barcelona->update({ is_published => 1 });
}

#set airport.is_published to 0
{
    my $malaga = $schema->resultset('Airport')->search({ id => 5 });
    $malaga->update({ is_published => 0 });

    my $iterator =
        request();

    is($iterator->count, 2, 'got 2 cities');
    is_MOW($iterator->next);
    is_BCN($iterator->next);

    $malaga->update({ is_published => 1 });
}

#set flight.is_published to 0
{
    my $NN332 = $schema->resultset('Flight')->search({ id => 2 });
    $NN332->update({ is_published => 0 });

    my $iterator = request();

    is($iterator->count, 2, 'get 2 cities');
    is_MOW($iterator->next);
    is_AGP($iterator->next);

    $NN332->update({ is_published => 1 });
}


