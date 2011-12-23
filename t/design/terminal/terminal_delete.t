use Test::More tests => 6;

use strict;
use warnings;

use_ok('ClubSpain::Model::Terminal');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

my $count = $helper->schema->resultset('Terminal')->search({})->count;

my $terminal = ClubSpain::Model::Terminal->new(
    airport_id   => 1,
    name         => 'xxxxx',
    is_published => 0,
);

my $object = $terminal->create();

isa_ok($object, 'ClubSpain::Schema::Result::Terminal');
is($object->airport_id, 1, 'got airport');
is($object->name, 'xxxxx', 'got name');
is($object->is_published, 0, 'got is published');


ClubSpain::Model::Terminal->delete($object->id);

my $rs = $helper->schema->resultset('Terminal')->search({});
is($rs->count, $count, 'no objects left');
