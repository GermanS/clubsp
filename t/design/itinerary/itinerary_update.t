use Test::More tests => 8;
use strict;
use warnings;
use lib qw(t/lib);
use ClubSpain::Constants qw(:all);
use ClubSpain::Test;
ClubSpain::Test->init_schema();

use_ok('ClubSpain::Model::Itinerary');

my $itinerary = ClubSpain::Model::Itinerary->new(
    id            => 1,
    timetable_id  => 7,
    fare_class_id => 2,
    parent_id     => 0,
    cost          => 200,
    is_published  => ENABLE,
);

my $result = $itinerary->update();

isa_ok($result, 'ClubSpain::Schema::Result::Itinerary');
is($result->id, 1, 'got id');
is($result->timetable_id,  7, 'got timetable id');
is($result->fare_class_id, 2, 'got fare class id');
is($result->parent_id,     0, 'got parent id');
is($result->cost,        200, 'got cost');
is($result->is_published,  1, 'got is_published');
