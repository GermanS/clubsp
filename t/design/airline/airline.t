use Test::More tests => 6;

use strict;
use warnings;

use_ok('ClubSpain::Model::Airline');

my $airline = ClubSpain::Model::Airline->new(
    iata        => 'S7',
    icao        => 'SBI',
    airline     => 'S7 Airlines',
    is_published => 1,
);


isa_ok($airline, 'ClubSpain::Model::Airline');
is($airline->iata, 'S7', 'got iata code');
is($airline->icao, 'SBI', 'got icao code');
is($airline->airline, 'S7 Airlines', 'got name');
is($airline->is_published, 1, 'got is published');
