use Test::More tests => 17;

use strict;
use warnings;

use_ok('ClubSpain::Model::Itinerary');

use ClubSpain::Constants qw(:all);

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

#pass id to the function
{
    my $itinerary = ClubSpain::Model::Itinerary->fetch_by_id(1);
    isa_ok($itinerary, 'ClubSpain::Schema::Result::Itinerary');
    is $itinerary->timetable_id, 7
        => 'got timetable id';
    is $itinerary->fare_class_id, 1
        => 'got fare class id';
    is $itinerary->parent_id, 0
        => 'got parent id';
    is $itinerary->cost, 175
        => 'got cost';
    is $itinerary->is_published, 1
        => 'got is published';
}


#retrive
{
    my $itinerary = ClubSpain::Model::Itinerary->new(
        id            => 1,
        timetable_id  => 0,
        fare_class_id => 0,
        parent_id     => 0,
        cost          => 0,
        is_published  => 0,
    );

    my $object = $itinerary->fetch_by_id();
    isa_ok($object, 'ClubSpain::Schema::Result::Itinerary');
    is $object->timetable_id,  7
        => 'got timetable id';
    is $object->fare_class_id, 1
        => 'got fare class id';
    is $object->parent_id,     0
        => 'got parent id';
    is $object->cost,        175
        => 'got cost';
    is $object->is_published,  1
        => 'got is_published';
}

#exception
{
    eval {
        ClubSpain::Model::Itinerary->fetch_by_id(1000);
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find Itinerary: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}

#exception
{
    my $itinerary = ClubSpain::Model::Itinerary->new(
        id             => 1000,
        timetable_id   => 0,
        fare_class_id  => 0,
        parent_id      => 0,
        cost           => 0,
        is_published   => 0,
    );

    eval {
        $itinerary->fetch_by_id();
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find Itinerary: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}
