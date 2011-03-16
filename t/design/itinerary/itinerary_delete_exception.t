use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::Model::Itinerary');

{
    eval {
        ClubSpain::Model::Itinerary->delete(1000);
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('Class method: caught Storage exception');
        } else {
            fail('cought other exception');
            diag $@;
        }
    }
}

{
    my $itinerary = ClubSpain::Model::Itinerary->new(
        id            => 230,
        timetable_id  => 1,
        fare_class_id => 1,
        parent_id     => 0,
        cost          => 0,
    );

    eval {
        $itinerary->delete();
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('Object Method: caught Storage exception');
        } else {
            fail('cought other exception');
            diag $@;
        }
    }
}
