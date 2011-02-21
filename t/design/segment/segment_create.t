use Test::More tests => 11;

use strict;
use warnings;

use_ok('ClubSpain::Model::Segment');

use lib qw(t/lib);
use ClubSpain::Test;

ClubSpain::Test->init_schema();

#first insert
{
    my $segment = ClubSpain::Model::Segment->new(
        fare_class_id => 1,
        fare_id       => 1,
        timetable_id  => 1,
    );

    my $result;

    eval {
        $result = $segment->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Result::Segment');
    is($result->fare_class_id, 1, 'got fare class id');
    is($result->fare_id,       1, 'got fare id');
    is($result->timetable_id,  1, 'got timetable id');
}

#second addition
{
    my $segment = ClubSpain::Model::Segment->new(
        fare_class_id   => 2,
        fare_id         => 1,
        timetable_id    => 2,
    );

    my $result;

    eval {
        $result = $segment->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Result::Segment');
    is($result->fare_class_id, 2, 'got fare class id');
    is($result->fare_id,       1, 'got fare id');
    is($result->timetable_id,  2, 'got timetable id');
}
