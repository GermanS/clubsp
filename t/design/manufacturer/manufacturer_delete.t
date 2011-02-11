use Test::More tests => 5;

use strict;
use warnings;

use_ok('ClubSpain::Model::Manufacturer');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();
my $count = $schema->resultset('Manufacturer')->search({})->count;

my $manufacturer = ClubSpain::Model::Manufacturer->new(
    code    => 'xxx',
    name    => 'xxx xxxx',
);

my $object = $manufacturer->create();

isa_ok($object, 'ClubSpain::Schema::Manufacturer');
is($object->code, 'xxx', 'got code');
is($object->name, 'xxx xxxx', 'got name');

ClubSpain::Model::Manufacturer->delete($object->id);

my $rs = $schema->resultset('Manufacturer')->search({});
is($rs->count, $count, 'no objects left');
