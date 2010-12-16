use Test::More tests => 7;

use strict;
use warnings;

use_ok('ClubSpain::Design::Airport');

my $port = ClubSpain::Design::Airport->new(
    city_id     => 1,
    iata        => 'dme',
    icao        => 'uudm',
    name        => 'Domodedovo',
    is_published => 1,
);


isa_ok($port, 'ClubSpain::Design::Airport');
is($port->city_id, 1, 'got city_id');
is($port->iata, 'dme', 'got iata code');
is($port->icao, 'uudm', 'got icao code');
is($port->name, 'Domodedovo', 'got name');
is($port->is_published, 1, 'got header');
