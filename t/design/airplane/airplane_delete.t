use Test::More tests => 8;

use strict;
use warnings;

use_ok('ClubSpain::Model::Airplane');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();
my $schema = $helper->schema;

my $count = $schema->resultset('Airplane')->search({})->count;

my $airplane = ClubSpain::Model::Airplane->new(
    iata => 'xxx',
    icao => 'xxxx',
    name => 'xxx xxxx',
    manufacturer_id => 1,
    is_published    => 0,
);

my $object = $airplane->create();

isa_ok($object, 'ClubSpain::Schema::Result::Airplane');
is $object->manufacturer_id, 1
    => 'got manufacturer code';
is $object->iata, 'xxx'
    => 'got iata code';
is $object->icao, 'xxxx'
    => 'got icao code';
is $object->name, 'xxx xxxx'
    => 'got name';
is $object->is_published, 0
    => 'got is published';


ClubSpain::Model::Airplane->delete($object->id);

my $rs = $schema->resultset('Airplane')->search({});
is($rs->count, $count, 'no objects left');
