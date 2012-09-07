use Test::More tests => 8;

use strict;
use warnings;

use_ok('ClubSpain::Model::Itinerary');

use lib qw(t/lib);
use ClubSpain::Constants qw(:all);

use ClubSpain::Test;
my $helper = ClubSpain::Test->new();
my $count = $helper->schema->resultset('Itinerary')->search({})->count;

my $itinerary = ClubSpain::Model::Itinerary->new(
    timetable_id  => 1,
    fare_class_id => 1,
    parent_id     => 0,
    cost          => 100,
    is_published  => ENABLE,
);

my $object = $itinerary->create();

isa_ok($object, 'ClubSpain::Schema::Result::Itinerary');
is $object->timetable_id, 1
    => 'got timetable id';
is $object->fare_class_id, 1
    => 'got fare class id';
is $object->parent_id, 0
    => 'got parent id';
is $object->cost, 100
    => 'got cost';
is $object->is_published, 1
    => 'got is_published';


ClubSpain::Model::Itinerary->delete($object->id);

my $rs = $helper->schema->resultset('Itinerary')->search({});
is($rs->count, $count, 'no objects left');
