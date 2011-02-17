use Test::More tests => 3;
use strict;
use warnings;

use_ok('ClubSpain::Model::Segment');

#call as class method
{
    eval {
        ClubSpain::Model::Segment->update();
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
    my $segment = ClubSpain::Model::Segment->new(
        id   => 777,
        fare_class_id => 0,
        fare_id       => 0,
        timetable_id  => 0
    );

    eval {
        $segment->update();
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
