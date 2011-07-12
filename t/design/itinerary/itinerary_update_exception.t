use Test::More tests => 3;
use strict;
use warnings;

use_ok('ClubSpain::Model::Itinerary');

#call as class method
{
    eval {
        ClubSpain::Model::Itinerary->update();
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Argument')) {
            pass('caught Argument exception');
        } else {
            diag ($@);
            fail('caught other exception');
        }
    }
}

#object does not exist in database
{
    my $itinerary = ClubSpain::Model::Itinerary->new(
        id            => 777,
        timetable_id  => 0,
        fare_class_id => 0,
        parent_id     => 0,
        cost          => 0,
        is_published  => 1,
    );

    eval {
        $itinerary->update();
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught Storage exception');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}
