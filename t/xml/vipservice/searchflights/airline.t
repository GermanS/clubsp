use Test::More tests => 4;

use strict;
use warnings;

use_ok( 'ClubSpain::XML::VipService::Response::FlightSearch::Airline' );

my %params = (
    name => 'aeroflot',
    code => 'su'
);

my $airline = ClubSpain::XML::VipService::Response::FlightSearch::Airline -> new( %params );

isa_ok $airline, 'ClubSpain::XML::VipService::Response::FlightSearch::Airline';

is $airline -> name(), $params{ 'name' }
    => sprintf 'got name: %s', $params{ 'name' };

is $airline -> code(), $params{ 'code' }
    => sprintf 'got code: %s', $params{ 'code' };