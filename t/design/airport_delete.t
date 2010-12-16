use Test::More tests => 8;

use strict;
use warnings;

use_ok('ClubSpain::Design::Airport');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();
my $count = $schema->resultset('Airport')->search({})->count;

my $port = ClubSpain::Design::Airport->new(
    city_id => 1,
    iata    => 'xxx',
    icao    => 'xxxx',
    name    => 'xxx xxxx',
    is_published    => 0,
);

my $object = $port->create();

isa_ok($object, 'ClubSpain::Schema::Airport');
is($object->city_id, 1, 'got city id');
is($object->iata, 'xxx', 'got iata code');
is($object->icao, 'xxxx', 'got icao code');
is($object->name, 'xxx xxxx', 'got name');
is($object->is_published, 0, 'got is published');


ClubSpain::Design::Airport->delete($object->id);

my $rs = $schema->resultset('Airport')->search({});
is($rs->count, $count, 'no objects left');
