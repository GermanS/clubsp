use Test::More tests => 7;

use strict;
use warnings;

use_ok('ClubSpain::Model::Itinerary');
use ClubSpain::Constants qw(:all);

my $itinerary = ClubSpain::Model::Itinerary->new(
    is_published   => ENABLE,
    timetable_id   => 1,
    fare_class_id  => 2,
    parent_id      => 0,
    cost           => 100
);

isa_ok($itinerary, 'ClubSpain::Model::Itinerary');
is($itinerary->timetable_id,  1, 'got timetable id');
is($itinerary->fare_class_id, 2, 'got fare class id');
is($itinerary->parent_id, 0, 'got fare id');
is($itinerary->cost, 100, 'got cost');
is($itinerary->is_published, 1, 'got is_published');
