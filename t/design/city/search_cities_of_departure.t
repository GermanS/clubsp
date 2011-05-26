use Test::More tests => 14;

use strict;
use warnings;

use lib qw(t/lib);
use ClubSpain::Test;

ClubSpain::Test->init_schema();

use_ok('ClubSpain::Model::City');

#searchCitiesOfDeparture();
{
    my $iterator =
        ClubSpain::Model::City->searchCitiesOfDeparture();

    is($iterator, undef, 'country param is missing');
}

#searchCitiesOfDeparture(country => russia);
{
    my $iterator =
        ClubSpain::Model::City->searchCitiesOfDeparture(country => 1);

    is($iterator->count, 1, 'got one city');

    my $moscow = $iterator->next;
    is($moscow->id, 1, 'got id');
    is($moscow->iata, 'MOW', 'got iata code');
    is($moscow->name, 'Moscow', 'got name');
}


#searchCitiesOfDeparture(country => spain);
{
    my $iterator =
        ClubSpain::Model::City->searchCitiesOfDeparture(country => 2);

    is($iterator->count, 2, 'got cities in spain');

    my $bcn = $iterator->next();
    is($bcn->id, 2, 'got id');
    is($bcn->iata, 'BCN', 'got iata code');
    is($bcn->name, 'Barcelona', 'got name');

    my $malaga = $iterator->next();
    is($malaga->id, 3, 'got id');
    is($malaga->iata, 'AGP', 'got iata code');
    is($malaga->name, 'Malaga', 'got name');
}

#searchCitiesOfDeparture(country => andorra);
{
    my $iterator =
        ClubSpain::Model::City->searchCitiesOfDeparture(country => 3);

    is($iterator->count, 0, 'got nothing in andorra');
}
