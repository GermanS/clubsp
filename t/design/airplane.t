use Test::More tests => 7;

use strict;
use warnings;

use_ok('ClubSpain::Design::Airplane');

my $airplane = ClubSpain::Design::Airplane->new(
    manufacturer_id => 1,
    iata            => '310',
    icao            => 'A310',
    name            => 'A310',
    is_published    => 1,
);


isa_ok($airplane, 'ClubSpain::Design::Airplane');
is($airplane->manufacturer_id, 1, 'got manufacturer');
is($airplane->iata, '310', 'got iata code');
is($airplane->icao, 'A310', 'got icao code');
is($airplane->name, 'A310', 'got name');
is($airplane->is_published, 1, 'got is published');
