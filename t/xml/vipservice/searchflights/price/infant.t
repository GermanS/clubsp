use Test::More tests => 4;

use strict;
use warnings;

use_ok( 'ClubSpain::XML::VipService::Response::FlightSearch::Price::Infant' );

my $price = ClubSpain::XML::VipService::Response::FlightSearch::Price::Infant -> new(
    amount      => 100,
    elementType => 'Infant'
);

isa_ok $price, 'ClubSpain::XML::VipService::Response::FlightSearch::Price::Infant';

is $price -> amount(), 100
    => 'got right amount field';

is $price -> elementType(), 'Infant'
    => 'got right elementType field';