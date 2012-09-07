use Test::More tests => 22;
use strict;
use warnings;

use lib qw(t/lib);
use ClubSpain::Constants qw(:all);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

use_ok('ClubSpain::Model::Itinerary');

#OW
{
    my $fare = ClubSpain::Model::Itinerary->new(
        id            => 1,
        timetable_id  => 7,
        fare_class_id => 2,
        parent_id     => 0,
        cost          => 500,
        is_published  => ENABLE,
    );

    my $result = $fare->update();

    isa_ok($result, 'ClubSpain::Schema::Result::Itinerary');
    is $result->id, 1
        => 'got id';
    is $result->timetable_id,  7
        => 'got timetable id';
    is $result->fare_class_id, 2
        => 'got fare class id';
    is $result->parent_id,     0
        => 'got parent id';
    is $result->cost, 500
        => 'got cost';
    is $result->is_published, 1
        => 'got is_published';

    ok(!$result->next_route, 'OW tarif');
}

#RT
{
    my $fare = ClubSpain::Model::Itinerary->new(
        id            => 5,
        timetable_id  => 7,
        fare_class_id => 2,
        cost          => 1234,
        is_published  => DISABLE,
    );

    my $result = $fare->update_fare();
    isa_ok($result, 'ClubSpain::Schema::Result::Itinerary');
    is $result->id, 5
        => 'got id';
    is $result->timetable_id, 7
        => 'got timetable id';
    is $result->fare_class_id, 2
        => 'got fare class id';
    is $result->parent_id, 0
        => 'got parent id';
    is $result->cost, 1234
        => 'got cost';
    is $result->is_published, 0
        => 'got is_published';

    my $return = $result->next_route;
    isa_ok($return, 'ClubSpain::Schema::Result::Itinerary');
    ok($return, 'RT tarif');
    is $return->parent_id, 5
        => 'check consistency';
    is $return->fare_class_id, $result->fare_class_id
        => 'fare clases are equal';
    is $return->cost, 0
        => 'the cost or return segment equals to 0';
    is $return->is_published, $result->is_published
        => 'is published flags are equal';
}
