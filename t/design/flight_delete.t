use Test::More tests => 7;

use strict;
use warnings;

use_ok('ClubSpain::Design::Flight');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();
my $count = $schema->resultset('Flight')->search({})->count;

my $flight = ClubSpain::Design::Flight->new(
    departure_airport_id    => 1,
    destination_airport_id  => 2,
    airline_id              => 1,
    code                    => 8331,
);

my $object = $flight->create();

isa_ok($object, 'ClubSpain::Schema::Flight');
is($object->departure_airport_id, 1, 'got departure airport');
is($object->destination_airport_id, 2, 'got destination airport');
is($object->airline_id, 1, 'got airline');
is($object->code, 8331, 'got is code');


ClubSpain::Design::Flight->delete($object->id);

my $rs = $schema->resultset('Flight')->search({});
is($rs->count, $count, 'no objects left');
