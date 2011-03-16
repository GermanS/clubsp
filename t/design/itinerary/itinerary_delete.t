use Test::More tests => 7;

use strict;
use warnings;

use_ok('ClubSpain::Model::Itinerary');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();
my $count = $schema->resultset('Itinerary')->search({})->count;

my $itinerary = ClubSpain::Model::Itinerary->new(
    timetable_id  => 1,
    fare_class_id => 1,
    parent_id     => 0,
    cost          => 100,
);

my $object = $itinerary->create();

isa_ok($object, 'ClubSpain::Schema::Result::Itinerary');
is($object->timetable_id,  1, 'got timetable id');
is($object->fare_class_id, 1, 'got fare class id');
is($object->parent_id,     0, 'got parent id');
is($object->cost,        100, 'got cost');


ClubSpain::Model::Itinerary->delete($object->id);

my $rs = $schema->resultset('Itinerary')->search({});
is($rs->count, $count, 'no objects left');
