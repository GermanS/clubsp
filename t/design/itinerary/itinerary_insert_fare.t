use Test::More tests => 20;
use strict;
use warnings;

use_ok('ClubSpain::Model::Itinerary');

use lib qw(t/lib);
use ClubSpain::Constants qw(:all);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

#insert of one way tariff
{
    my $itinerary = ClubSpain::Model::Itinerary->new(
        timetable_id  => 1,
        return_segment=> 0,
        fare_class_id => 1,
        parent_id     => 0,
        cost          => 550,
        is_published  => ENABLE,
    );

    my $result;

    eval {
        $result = $itinerary->insert_fare();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
    }

    isa_ok($result, 'ClubSpain::Schema::Result::Itinerary');
    is $result->timetable_id, 1
        => 'got timetable id';
    is $result->fare_class_id, 1
        => 'got fare class id';
    is $result->parent_id, 0
        => 'got parent';
    is $result->cost, 550
        => 'got cost';
    is $result->is_published, 1
        => 'got is published';

    ok(!$result->next_route(), 'there is only one segment');
}

#insert of round trip tariff
{
    my $itinerary = ClubSpain::Model::Itinerary->new(
        timetable_id  => 1,
        return_segment=> 2,
        fare_class_id => 1,
        parent_id     => 0,
        cost          => 990,
        is_published  => ENABLE,
    );

    my $result;

    eval {
        $result = $itinerary->insert_fare();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
    }

    isa_ok($result, 'ClubSpain::Schema::Result::Itinerary');
    is $result->timetable_id, 1
        => 'got timetable id';
    is $result->fare_class_id, 1
        => 'got fare class id';
    is $result->parent_id, 0
        => 'got parent';
    is $result->cost, 990
        => 'got cost';
    is $result->is_published, 1
        => 'got is published';

    my $return_segment = $result->next_route();
    is $return_segment->timetable_id, 2
        => 'got timetable of return segment';
    is $return_segment->fare_class_id, 1
        => 'got fare class';
    is $return_segment->cost, 0
        => 'the cost of return segment equals to 0';
    is $return_segment->is_published, 1,
        => 'it is enabled';
}
