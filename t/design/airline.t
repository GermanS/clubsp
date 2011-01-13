use Test::More tests => 6;

use strict;
use warnings;

use_ok('ClubSpain::Design::Airline');

my $airline = ClubSpain::Design::Airline->new(
    iata        => 'S7',
    icao        => 'SBI',
    name        => 'S7 Airlines',
    is_published => 1,
);


isa_ok($airline, 'ClubSpain::Design::Airline');
is($airline->iata, 'S7', 'got iata code');
is($airline->icao, 'SBI', 'got icao code');
is($airline->name, 'S7 Airlines', 'got name');
is($airline->is_published, 1, 'got is published');
