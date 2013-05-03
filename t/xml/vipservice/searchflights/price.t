use Test::More tests => 8;

use strict;
use warnings;

use_ok( 'ClubSpain::XML::VipService::Response::FlightSearch::Price' );

use_ok( 'ClubSpain::XML::VipService::Response::FlightSearch::Price::Adult' );
use_ok( 'ClubSpain::XML::VipService::Response::FlightSearch::Price::Child' );
use_ok( 'ClubSpain::XML::VipService::Response::FlightSearch::Price::Infant' );

my $price = ClubSpain::XML::VipService::Response::FlightSearch::Price -> new();

isa_ok $price, 'ClubSpain::XML::VipService::Response::FlightSearch::Price';

my @params = ({
        passengerType => 'ADULT',
        amount        => 100,
    }, {
        passengerType => 'ADULT',
        amount        => 125,
    }, {
        passengerType => 'ADULT',
        amount        => 150,
    }, {
        passengerType => 'CHILD',
        amount        => 45,
    }, {
        passengerType => 'CHILD',
        amount        => 55,
    }, {
        passengerType => 'INFANT',
        amount        => 15,
});

$price -> initialize( \@params );

is $price -> count_adults(), 3
    => 'got 3 adults';

is $price -> count_children(), 2
    => 'got 2 children';

is $price -> count_infants(), 1
    => 'got an infant';