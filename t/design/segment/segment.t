use Test::More tests => 5;

use strict;
use warnings;

use_ok('ClubSpain::Model::Segment');

my $segment = ClubSpain::Model::Segment->new(
    timetable_id   => 1,
    fare_class_id  => 2,
    fare_id        => 1,
);

isa_ok($segment, 'ClubSpain::Model::Segment');
is($segment->timetable_id,  1, 'got timetable id');
is($segment->fare_class_id, 2, 'got fare class id');
is($segment->fare_id, 1, 'got fare id');
