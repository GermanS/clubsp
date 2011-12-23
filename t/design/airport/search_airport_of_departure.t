use Test::More tests => 6;
use strict;
use warnings;

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

use_ok('ClubSpain::Model::Airport');

#searchAirportOfDeparture()
{
    my $iterator =
        ClubSpain::Model::Airport->searchAirportsOfDeparture();

    is($iterator, undef, 'got nothing');
}

#searchAirportsOfDeparture( city => barcelona )
{
    my $iterator =
        ClubSpain::Model::Airport->searchAirportsOfDeparture( city => 2);

    is($iterator->count, 1, 'got one airport');
    my $elprat = $iterator->next();
    is($elprat->id, 4, 'got airport id');
    is($elprat->iata, 'BCN', 'got iate code');


    #set barcelona's is_published=0
    $elprat->city->update({ is_published => 0 });

    $iterator =
       ClubSpain::Model::Airport->searchAirportsOfDeparture( city => 2 );

    is($iterator->count, 0, 'nothing to select');
}

