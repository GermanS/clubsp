use Test::More tests => 8;

use strict;
use warnings;

use_ok('ClubSpain::Model::Flight');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();
my $count = $schema->resultset('Flight')->search({})->count;

my $flight = ClubSpain::Model::Flight->new(
    is_published            => 1,
    departure_airport_id    => 1,
    destination_airport_id  => 2,
    airline_id              => 1,
    code                    => 8331,
);

my $object = $flight->create();

isa_ok($object, 'ClubSpain::Schema::Flight');
is($object->is_published, 1, 'got is published');
is($object->departure_airport_id, 1, 'got departure airport');
is($object->destination_airport_id, 2, 'got destination airport');
is($object->airline_id, 1, 'got airline');
is($object->code, 8331, 'got is code');


ClubSpain::Model::Flight->delete($object->id);

my $rs = $schema->resultset('Flight')->search({});
is($rs->count, $count, 'no objects left');
