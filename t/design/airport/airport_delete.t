use Test::More tests => 8;

use strict;
use warnings;

use_ok('ClubSpain::Model::Airport');

use lib qw(t/lib);
use ClubSpain::Test;

my $helper = ClubSpain::Test->new();
my $schema = $helper->schema;

my $count = $schema->resultset('Airport')->search({})->count;

my $port = ClubSpain::Model::Airport->new(
    iata => 'xxx',
    icao => 'xxxx',
    name => 'xxx xxxx',
    city_id      => 1,
    is_published => 0,
);

my $object = $port->create();

isa_ok($object, 'ClubSpain::Schema::Result::Airport');
is $object->city_id, 1
    => 'got city id';
is $object->iata, 'xxx'
    => 'got iata code';
is $object->icao, 'xxxx'
    => 'got icao code';
is $object->name, 'xxx xxxx'
    => 'got name';
is $object->is_published, 0
    => 'got is published';


ClubSpain::Model::Airport->delete($object->id);

my $rs = $schema->resultset('Airport')->search({});
is($rs->count, $count, 'no objects left');
