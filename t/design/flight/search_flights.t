use Test::More tests => 14;
use strict;
use warnings;
use lib qw(t/lib);
use ClubSpain::Test;
my $schema = ClubSpain::Test->init_schema();

use_ok('ClubSpain::Model::Flight');

#search flights moscow - barcelona
{
    my $iterator = ClubSpain::Model::Flight->searchFlights(
        cityOfDeparture => 1,
        cityOfArrival   => 2,
    );

    is($iterator->count, 1, 'got one flight');

    my $NN331 = $iterator->next();
    is($NN331->id, 1, 'got id');
    is($NN331->code, '331', 'got code');
}

#search flight malaga - moscow
{
    my $iterator = ClubSpain::Model::Flight->searchFlights(
        cityOfDeparture => 3,
        cityOfArrival   => 1,
    );

    is($iterator->count, 1, 'got one flight');

    my $IB990 = $iterator->next();
    is($IB990->id, '4', 'got id');
    is($IB990->code, 990, 'got code');
}

#set country.is_published to 0
{
    my $russia = $schema->resultset('Country')->search({ id => 1 });
    $russia->update({ is_published => 0 });

    my $iterator = ClubSpain::Model::Flight->searchFlights(
        cityOfDeparture => 1,
        cityOfArrival   => 2,
    );

    is($iterator->count, 0, 'got nothing');

    $russia->update({ is_published => 1 });
}

#set city.is_published to 0
{
    my $moscow = $schema->resultset('City')->search({ id => 1 });
    $moscow->update({ is_published => 0 });

    my $iterator = ClubSpain::Model::Flight->searchFlights(
        cityOfDeparture => 1,
        cityOfArrival   => 2,
    );

    is($iterator->count, 0, 'got nothing');

    $moscow->update({ is_published => 1 });
}

#set airport.is_published to 0
{
    my $malaga = $schema->resultset('Airport')->search({ id => 5 });
    $malaga->update({ is_published => 0 });

    my $iterator = ClubSpain::Model::Flight->searchFlights(
        cityOfDeparture => 1,
        cityOfArrival   => 3,
    );

    is($iterator->count, 0, 'got nothing');

    $malaga->update({ is_published => 1 });
}

#set flight.is_published to 0
{
    my $NN331 = $schema->resultset('Flight')->search({ id => 1 });
    $NN331->update({ is_published => 0 });

    my $iterator = ClubSpain::Model::Flight->searchFlights(
        cityOfDeparture => 1,
        cityOfArrival   => 2,
    );

    is($iterator->count, 0, 'got nothing');

    #returning
    $iterator = ClubSpain::Model::Flight->searchFlights(
        cityOfDeparture => 2,
        cityOfArrival   => 1,
    );

    is($iterator->count, 1, 'got one flight');

    my $NN332 = $iterator->next();
    is($NN332->id, 2, 'got id');
    is($NN332->code, 332, 'got code');

    $NN331->update({ is_published => 1 });
}
