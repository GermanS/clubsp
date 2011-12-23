use Test::More tests => 8;
use strict;
use warnings;

use lib qw(t/lib);
use ClubSpain::Test;

my $helper = ClubSpain::Test->new();

use_ok('ClubSpain::Model::Airplane');

my $airplane = ClubSpain::Model::Airplane->new(
    id          => 1,
    manufacturer_id => 1,
    iata        => 'zzz',
    icao        => 'cccc',
    name        => 'New Airplane name',
    is_published=> 0,
);

my $result = $airplane->update();

isa_ok($result, 'ClubSpain::Schema::Result::Airplane');
is($result->id, 1, 'got id');
is($result->manufacturer_id, 1, 'got manufacturer code');
is($result->iata, 'zzz', 'got iata code');
is($result->icao, 'cccc', 'got icao code');
is($result->name, 'New Airplane name', 'got name');
is($result->is_published, 0, 'got is_published');
