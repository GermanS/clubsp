use Test::More tests => 7;
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
