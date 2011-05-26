use Test::More tests => 28;
use strict;
use warnings;

use lib qw(t/lib);
use ClubSpain::Test;
my $schema = ClubSpain::Test->init_schema();

use_ok('ClubSpain::Model::City');

#search -  moscow is the city od departure
{
    my $iterator =
        ClubSpain::Model::City->searchCitiesOfArrivalInFlight(cityOfDeparture => 1);

    is($iterator->count, 2, 'got 2 cities of arrival');

    my $barcelona = $iterator->next();
    is($barcelona->id, 2, 'got id');
    is($barcelona->iata, 'BCN', 'got iata code');
    is($barcelona->name, 'Barcelona', 'got barcelona');

    my $malaga = $iterator->next();
    is($malaga->id, 3, 'got id');
    is($malaga->iata, 'AGP', 'got iata code');
    is($malaga->name, 'Malaga', 'got Malaga');
}

#search - barcelona is the city of departure
{
    my $iterator =
        ClubSpain::Model::City->searchCitiesOfArrivalInFlight(cityOfDeparture => 2);

    is($iterator->count, 1, 'got one city of arrival');

    my $moscow = $iterator->next();
    is($moscow->id, 1, 'got id');
    is($moscow->iata, 'MOW', 'got iata code');
    is($moscow->name, 'Moscow', 'got Moscow');
}

# search - malaga is the city of departure
{
    my $iterator =
        ClubSpain::Model::City->searchCitiesOfArrivalInFlight(cityOfDeparture => 3);

    is($iterator->count, 1, 'got one city of arrival');

    my $moscow = $iterator->next();
    is($moscow->id, 1, 'got id');
    is($moscow->iata, 'MOW', 'got iata code');
    is($moscow->name, 'Moscow', 'got Moscow');
}

#set country.is_published to 0
{
    my $spain = $schema->resultset('Country')->search({ id => 2 });
    $spain->update({ is_published => 0 });

    my $iterator =
        ClubSpain::Model::City->searchCitiesOfArrivalInFlight(cityOfDeparture => 1);

    is($iterator->count, 0, 'got nothing');

    $spain->update({ is_published => 1 });
}

#set city.is_published to 0
{
    my $barcelona = $schema->resultset('City')->search({ id => 2 });
    $barcelona->update({ is_published => 0 });

    my $iterator =
        ClubSpain::Model::City->searchCitiesOfArrivalInFlight(cityOfDeparture => 1);

    is($iterator->count, 1, 'got one city');

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
        ClubSpain::Model::City->searchCitiesOfArrivalInFlight(cityOfDeparture => 1);

    my $barcelona = $iterator->next();
    is($barcelona->id, 2, 'got id');
    is($barcelona->iata, 'BCN', 'got iata code');
    is($barcelona->name, 'Barcelona', 'got Barcelona');

    $malaga->update({ is_published => 1 });
}

#set flight.is_published to 0
{
    my $NN331 = $schema->resultset('Flight')->search({ id => 1 });
    $NN331->update({ is_published => 0 });

    my $iterator =
        ClubSpain::Model::City->searchCitiesOfArrivalInFlight(cityOfDeparture => 1);

    is($iterator->count, 1, 'got one city');

    my $malaga = $iterator->next();
    is($malaga->id, 3, 'got id');
    is($malaga->iata, 'AGP', 'got iata code');
    is($malaga->name, 'Malaga', 'got Malaga');

    $NN331->update({ is_published => 1 });
}
