use Test::More tests => 6;

use strict;
use warnings;

use_ok('ClubSpain::Design::FareClass');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();
my $count = $schema->resultset('FareClass')->search({})->count;

my $fareclass = ClubSpain::Design::FareClass->new(
    code    => 'x',
    name    => 'xxxxx',
    is_published => 0,
);

my $object = $fareclass->create();

isa_ok($object, 'ClubSpain::Schema::FareClass');
is($object->code, 'x', 'got code');
is($object->name, 'xxxxx', 'got name');
is($object->is_published, 0, 'got is published');


ClubSpain::Design::FareClass->delete($object->id);

my $rs = $schema->resultset('FareClass')->search({});
is($rs->count, $count, 'no objects left');
