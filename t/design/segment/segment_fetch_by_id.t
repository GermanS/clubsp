use Test::More tests => 13;

use strict;
use warnings;

use_ok('ClubSpain::Model::Segment');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();

#pass id to the function
{
    my $segment = ClubSpain::Model::Segment->fetch_by_id(1);
    isa_ok($segment, 'ClubSpain::Schema::Result::Segment');
    is($segment->fare_class_id, 1, 'got fare class id');
    is($segment->fare_id,       1, 'got fare id');
    is($segment->timetable_id,  1, 'got timetable id');
}


#retrive
{
    my $segment = ClubSpain::Model::Segment->new(
        id            => 1,
        fare_class_id => 0,
        fare_id       => 0,
        timetable_id  => 0
    );

    my $object = $segment->fetch_by_id();
    isa_ok($object, 'ClubSpain::Schema::Result::Segment');
    is($object->fare_class_id, 1, 'got fare class id');
    is($object->fare_id,       1, 'got fare id');
    is($object->timetable_id,  1, 'got timetable id');
}

#exception
{
    eval {
        ClubSpain::Model::Segment->fetch_by_id(1000);
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find Segment: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}

#exception
{
    my $segment = ClubSpain::Model::Segment->new(
        id          => 1000,
        fare_class_id  => 0,
        fare_id        => 0,
        timetable_id   => 0,
    );

    eval {
        $segment->fetch_by_id();
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find Segment: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}
