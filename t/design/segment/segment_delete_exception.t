use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::Model::Segment');

{
    eval {
        ClubSpain::Model::Segment->delete(1000);
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
    my $segment = ClubSpain::Model::Segment->new(
        id            => 23,
        fare_class_id => 1,
        fare_id       => 1,
        timetable_id  => 1
    );

    eval {
        $segment->delete();
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
