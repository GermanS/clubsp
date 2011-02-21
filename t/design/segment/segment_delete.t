use Test::More tests => 6;

use strict;
use warnings;

use_ok('ClubSpain::Model::Segment');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();
my $count = $schema->resultset('Segment')->search({})->count;

my $segment = ClubSpain::Model::Segment->new(
    fare_class_id => 1,
    fare_id       => 3,
    timetable_id  => 1,
);

my $object = $segment->create();

isa_ok($object, 'ClubSpain::Schema::Result::Segment');
is($object->fare_class_id, 1, 'got fare class id');
is($object->fare_id,       3, 'got fare id');
is($object->timetable_id,  1, 'got timetable id');


ClubSpain::Model::Segment->delete($object->id);

my $rs = $schema->resultset('Segment')->search({});
is($rs->count, $count, 'no objects left');
