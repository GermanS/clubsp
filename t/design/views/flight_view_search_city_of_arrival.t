use Test::More tests => 27;
use strict;
use warnings;

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();
my $schema = $helper->schema;

my $MOW = $helper->moscow();
sub is_MOW {
    my $mow = shift;

    is($mow->id, $MOW->id, 'got id');
    is($mow->iata, $MOW->iata, 'got iata code');
    is($mow->name, $MOW->name, 'got Moscow');
}

my $BCN = $helper->barcelona();
sub is_BCN {
    my $bcn = shift;

    is($bcn->id, $BCN->id, 'got id');
    is($bcn->iata, $BCN->iata, 'got iata code');
    is($bcn->name, $BCN->name, 'got Barcelona');
}

my $AGP = $schema->resultset('City')->search({ id => 3 })->single();
sub is_AGP {
    my $agp = shift;

    is($agp->id, 3, 'got id: ' . $AGP->id);
    is($agp->iata, 'AGP', 'got iata code: '.$AGP->iata);
    is($agp->name, 'Malaga', 'got city:'.$AGP->name);
}

sub request {
    my %params = @_;

    return $schema->resultset('ViewFlight')->searchCitiesOfArrival( %params );
}

#search -  moscow is the city of departure
{
    my $iterator = request(cityOfDeparture => $MOW->id);

    is($iterator->count, 2, 'got 2 cities of arrival');

    is_BCN($iterator->next);
    is_AGP($iterator->next);
}

#search - barcelona is the city of departure
{
    my $iterator = request(cityOfDeparture => $BCN->id);

    is($iterator->count, 1, 'got one city of arrival');
    is_MOW($iterator->next)
}

# search - malaga is the city of departure
{
    my $iterator = request(cityOfDeparture => $AGP->id);

    is($iterator->count, 1, 'got one city of arrival');
    is_MOW($iterator->next);
}

#set country.is_published to 0
{
    my $spain = $schema->resultset('Country')->search({ id => 2 });
    $spain->update({ is_published => 0 });

    my $iterator = request(cityOfDeparture => $MOW->id);
    is($iterator->count, 0, 'got nothing');

    $spain->update({ is_published => 1 });
}

#set city.is_published to 0
{
    my $barcelona = $schema->resultset('City')->search({ id => 2 });
    $barcelona->update({ is_published => 0 });

    my $iterator = request(cityOfDeparture => $MOW->id);
    is($iterator->count, 1, 'got one city');
    is_AGP($iterator->next);

    $barcelona->update({ is_published => 1 });
}

#set airport.is_published to 0
{
    my $malaga = $schema->resultset('Airport')->search({ id => 5 });
    $malaga->update({ is_published => 0 });

    my $iterator = request(cityOfDeparture => $MOW->id);
    is_BCN($iterator->next);

    $malaga->update({ is_published => 1 });
}

#set flight.is_published to 0
{
    my $NN331 = $schema->resultset('Flight')->search({ id => 1 });
    $NN331->update({ is_published => 0 });

    my $iterator = request(cityOfDeparture => $MOW->id);

    is($iterator->count, 1, 'got one city');
    is_AGP($iterator->next);

    $NN331->update({ is_published => 1 });
}
