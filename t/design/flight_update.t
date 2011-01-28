use Test::More tests => 7;
use strict;
use warnings;
use lib qw(t/lib);
use ClubSpain::Test;
ClubSpain::Test->init_schema();

use_ok('ClubSpain::Model::Flight');

my $flight = ClubSpain::Model::Flight->new(
    id                      => 1,
    departure_airport_id    => 2,
    destination_airport_id  => 3,
    airline_id              => 2,
    code                    => 321
);

my $result = $flight->update();

isa_ok($result, 'ClubSpain::Schema::Flight');
is($result->id, 1, 'got id');
is($result->departure_airport_id, 2, 'got departure airport');
is($result->destination_airport_id, 3, 'got destination airport');
is($result->airline_id, 2, 'got airline');
is($result->code, 321, 'got code');
