use Test::More tests => 36;
use strict;
use warnings;
use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();

use_ok('ClubSpain::Model::City');

{
    my $iterator = ClubSpain::Model::City->searchCitiesOfDepartureInFlight();

    is($iterator->count, 3, 'got three cities');

    my $moscow = $iterator->next();
    is($moscow->id, 1, 'got id');
    is($moscow->iata, 'MOW', 'got iata code');
    is($moscow->name, 'Moscow', 'got moscow');

    my $bcn = $iterator->next();
    is($bcn->id, 2, 'got id');
    is($bcn->iata, 'BCN', 'got iata code');
    is($bcn->name, 'Barcelona', 'got barcelona');

    my $mal = $iterator->next();
    is($mal->id, 3, 'got id');
    is($mal->iata, 'AGP', 'got iata code');
    is($mal->name, 'Malaga', 'got malaga');
}

#set country.is_published to 0
{
    my $spain = $schema->resultset('Country')->search({id => 2});
    $spain->update({ is_published => 0 });

    my $iterator =
        ClubSpain::Model::City->searchCitiesOfDepartureInFlight();

    is($iterator->count, 1, 'got city');
    my $moscow = $iterator->next();
    is($moscow->id, 1, 'got id');
    is($moscow->iata, 'MOW', 'got iata code');
    is($moscow->name, 'Moscow', 'got name');

    $spain->update({ is_published => 1 });
}

#set city.is_published to 0
{
    my $barcelona = $schema->resultset('City')->search({id => 2});
    $barcelona->update({ is_published => 0 });

    my $iterator =
        ClubSpain::Model::City->searchCitiesOfDepartureInFlight();

    is($iterator->count, 2, 'got 2 cities');

    my $moscow = $iterator->next();
    is($moscow->id, 1, 'got id');
    is($moscow->iata, 'MOW', 'got iata code');
    is($moscow->name, 'Moscow', 'got Moscow');

    my $malaga = $iterator->next();
    is($malaga->id, 3, 'got id');
    is($malaga->iata, 'AGP', 'got iata code');
    is($malaga->name, 'Malaga', 'got Malaga');

    $barcelona->update({ is_published => 1 });
}

#set airport.is_published to 0
{
    my $malaga = $schema->resultset('Airport')->search({ id => 5 });
    $malaga->update({ is_published => 0 });

    my $iterator =
        ClubSpain::Model::City->searchCitiesOfDepartureInFlight();

    is($iterator->count, 2, 'got 2 cities');

    my $moscow = $iterator->next();
    is($moscow->id, 1, 'got id');
    is($moscow->iata, 'MOW', 'got iata code');
    is($moscow->name, 'Moscow', 'got moscow');

    my $barcelona = $iterator->next();
    is($barcelona->id, 2, 'got id');
    is($barcelona->iata, 'BCN', 'got iata code');
    is($barcelona->name, 'Barcelona', 'got barcelona');

    $malaga->update({ is_published => 1 });
}

#set flight.is_published to 0
{
    my $NN332 = $schema->resultset('Flight')->search({ id => 2 });
    $NN332->update({ is_published => 0 });

    my $iterator =
        ClubSpain::Model::City->searchCitiesOfDepartureInFlight();

    is($iterator->count, 2, 'get 2 cities');

    my $moscow = $iterator->next();
    is($moscow->id, 1, 'got id');
    is($moscow->iata, 'MOW', 'got iata code');
    is($moscow->name, 'Moscow', 'got moscow');

    my $malaga = $iterator->next();
    is($malaga->id, 3, 'got id');
    is($malaga->iata, 'AGP', 'got iata code');
    is($malaga->name, 'Malaga', 'got malaga');

    $NN332->update({ is_published => 1 });
}


