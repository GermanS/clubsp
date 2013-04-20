use Test::More tests => 4;

use strict;
use warnings;

use_ok( 'ClubSpain::XML::VipService::Response::FlightSearch::Board' );

my %params = (
    code => 'A320',
    name => 'A320-100'
);
my $board = ClubSpain::XML::VipService::Response::FlightSearch::Board -> new( %params );

isa_ok $board, 'ClubSpain::XML::VipService::Response::FlightSearch::Board';

is $board -> code(), $params{ 'code' }
    => sprintf 'got right code: %s', $params{ 'code' };

is $board -> name(), $params{ 'name' }
    => sprintf 'got right name: %s', $params{ 'name' };