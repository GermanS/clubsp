use Test::More tests => 4;

use strict;
use warnings;

use_ok( 'ClubSpain::XML::VipService::Response::FlightSearch::Location' );

my %params = (
    code => 'BCN',
    name => 'Barcelona'
);
my $location = ClubSpain::XML::VipService::Response::FlightSearch::Location -> new( %params );

isa_ok $location, 'ClubSpain::XML::VipService::Response::FlightSearch::Location';

is $location -> code(), $params{ 'code' }
    => sprintf 'got code: %s', $params{ 'code' };

is $location -> name(), $params{ 'name' }
    => sprintf 'got name: %s', $params{ 'name' };