use Test::More tests => 7;
use strict;
use warnings;

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

use_ok('ClubSpain::Model::Airline');

my $airline = ClubSpain::Model::Airline->new(
    id          => 1,
    iata        => 'zz',
    icao        => 'ccc',
    name        => 'New Airline name',
    is_published=> 0,
);

my $result = $airline->update();

isa_ok($result, 'ClubSpain::Schema::Result::Airline');
is($result->id, 1, 'got id');
is($result->iata, 'zz', 'got iata code');
is($result->icao, 'ccc', 'got icao code');
is($result->name, 'New Airline name', 'got name');
is($result->is_published, 0, 'got is_published');
