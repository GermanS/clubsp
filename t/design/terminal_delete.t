use Test::More tests => 6;

use strict;
use warnings;

use_ok('ClubSpain::Design::Terminal');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();
my $count = $schema->resultset('Terminal')->search({})->count;

my $airline = ClubSpain::Design::Terminal->new(
    airport_id   => 1,
    name         => 'xxxxx',
    is_published => 0,
);

my $object = $airline->create();

isa_ok($object, 'ClubSpain::Schema::Terminal');
is($object->airport_id, 1, 'got airport');
is($object->name, 'xxxxx', 'got name');
is($object->is_published, 0, 'got is published');


ClubSpain::Design::Terminal->delete($object->id);

my $rs = $schema->resultset('Terminal')->search({});
is($rs->count, $count, 'no objects left');
