use Test::More tests => 4;

use strict;
use warnings;

use_ok( 'ClubSpain::XML::VipService::Response::FlightSearch::Price::Adult' );

my $price = ClubSpain::XML::VipService::Response::FlightSearch::Price::Adult -> new(
    amount      => 100,
    elementType => 'ADULT'
);

isa_ok $price, 'ClubSpain::XML::VipService::Response::FlightSearch::Price::Adult';

is $price -> amount(), 100
    => 'got right amount field';

is $price -> elementType(), 'ADULT'
    => 'got right elementType field';