use Test::More tests => 4;

use strict;
use warnings;

use_ok( 'ClubSpain::XML::VipService::Response::FlightSearch::Price::Child' );

my $price = ClubSpain::XML::VipService::Response::FlightSearch::Price::Child -> new(
    amount      => 100,
    elementType => 'Child'
);

isa_ok $price, 'ClubSpain::XML::VipService::Response::FlightSearch::Price::Child';

is $price -> amount(), 100
    => 'got right amount field';

is $price -> elementType(), 'Child'
    => 'got right elementType field';