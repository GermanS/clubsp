use Test::More tests => 6;
use strict;
use warnings;
use lib qw(t/lib);
use ClubSpain::Test;
ClubSpain::Test->init_schema();

use_ok('ClubSpain::Model::Segment');

my $segment = ClubSpain::Model::Segment->new(
    id      => 1,
    fare_class_id => 2,
    fare_id       => 2,
    timetable_id  => 2,
);

my $result = $segment->update();

isa_ok($result, 'ClubSpain::Schema::Segment');
is($result->id, 1, 'got id');
is($result->fare_class_id, 2, 'got fare class id');
is($result->fare_id,       2, 'got fare id');
is($result->timetable_id,  2, 'got timetable id');
