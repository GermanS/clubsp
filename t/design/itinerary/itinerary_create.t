use Test::More tests => 15;

use strict;
use warnings;

use_ok('ClubSpain::Model::Itinerary');

use lib qw(t/lib);
use ClubSpain::Constants qw(:all);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

#first insert
{
    my $itinerary = ClubSpain::Model::Itinerary->new(
        timetable_id  => 1,
        fare_class_id => 1,
        parent_id     => 0,
        cost          => 100,
        is_published  => ENABLE,
    );

    my $result;

    eval {
        $result = $itinerary->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Result::Itinerary');
    is($result->timetable_id,  1, 'got timetable id');
    is($result->fare_class_id, 1, 'got fare class id');
    is($result->parent_id,     0, 'got parent');
    is($result->cost,        100, 'got cost');
    is($result->is_published,  1, 'got is published');
}

#second addition
{
    my $itinerary = ClubSpain::Model::Itinerary->new(
        timetable_id    => 2,
        fare_class_id   => 2,
        parent_id       => 0,
        cost            => 0,
        is_published    => ENABLE,
    );

    my $result;

    eval {
        $result = $itinerary->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Result::Itinerary');
    is($result->timetable_id,  2, 'got timetable id');
    is($result->fare_class_id, 2, 'got fare class id');
    is($result->parent_id,     0, 'got parent id');
    is($result->cost,          0, 'got cost');
    is($result->is_published,  1, 'got is_published');
}
