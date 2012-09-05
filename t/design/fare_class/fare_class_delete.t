use Test::More tests => 6;
use strict;
use warnings;
use_ok('ClubSpain::Model::FareClass');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();
my $count = $helper->schema->resultset('FareClass')->search({})->count;

my $fareclass = ClubSpain::Model::FareClass->new(
    code    => 'x',
    name    => 'xxxxx',
    is_published => 0,
);

my $object = $fareclass->create();

isa_ok($object, 'ClubSpain::Schema::Result::FareClass');
is $object->code, 'x'
    => 'got code';
is $object->name, 'xxxxx'
    => 'got name';
is $object->is_published, 0
    => 'got is published';


ClubSpain::Model::FareClass->delete($object->id);

my $rs = $helper->schema->resultset('FareClass')->search({});
is($rs->count, $count, 'no objects left');
