use Test::More tests => 8;
use strict;
use warnings;
use lib qw(t/lib);
use ClubSpain::Test;
ClubSpain::Test->init_schema();

use_ok('ClubSpain::Design::Airport');

my $port = ClubSpain::Design::Airport->new(
    id          => 1,
    city_id     => 2,
    iata        => 'zzz',
    icao        => 'cccc',
    name        => 'New Airport name',
    is_published=> 0,
);

my $result = $port->update();

isa_ok($result, 'ClubSpain::Schema::Airport');
is($result->id, 1, 'got id');
is($result->city_id, 2, 'got city id');
is($result->iata, 'zzz', 'got iata code');
is($result->icao, 'cccc', 'got icao code');
is($result->name, 'New Airport name', 'got name');
is($result->is_published, 0, 'got is_published');
