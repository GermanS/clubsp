use Test::More tests => 7;

use strict;
use warnings;

use_ok('ClubSpain::Model::Airport');

my $port = ClubSpain::Model::Airport->new(
    city_id     => 1,
    iata        => 'dme',
    icao        => 'uudm',
    airport     => 'Domodedovo',
    is_published => 1,
);


isa_ok($port, 'ClubSpain::Model::Airport');
is($port->city_id, 1, 'got city_id');
is($port->iata, 'dme', 'got iata code');
is($port->icao, 'uudm', 'got icao code');
is($port->airport, 'Domodedovo', 'got name');
is($port->is_published, 1, 'got header');
