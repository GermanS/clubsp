use Test::More tests => 8;

use strict;
use warnings;

use_ok('ClubSpain::Design::Airplane');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();
my $count = $schema->resultset('Airplane')->search({})->count;

my $airplane = ClubSpain::Design::Airplane->new(
    manufacturer_id => 1,
    iata    => 'xxx',
    icao    => 'xxxx',
    name    => 'xxx xxxx',
    is_published => 0,
);

my $object = $airplane->create();

isa_ok($object, 'ClubSpain::Schema::Airplane');
is($object->manufacturer_id, 1, 'got manufacturer code');
is($object->iata, 'xxx', 'got iata code');
is($object->icao, 'xxxx', 'got icao code');
is($object->name, 'xxx xxxx', 'got name');
is($object->is_published, 0, 'got is published');


ClubSpain::Design::Airplane->delete($object->id);

my $rs = $schema->resultset('Airplane')->search({});
is($rs->count, $count, 'no objects left');
