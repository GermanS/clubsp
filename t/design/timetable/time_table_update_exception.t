use Test::More tests => 3;
use strict;
use warnings;

use_ok('ClubSpain::Model::TimeTable');

#call as class method
{
    eval {
        ClubSpain::Model::TimeTable->update();
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
    my $timetable = ClubSpain::Model::TimeTable->new(
        id           => 777,
        is_published      => 0,
        flight_id         => 2,
        airplane_id       => 2,
        departure_date    => '2012-01-01',
        departure_time    => '01:01',
        arrival_date      => '2012-01-01',
        arrival_time      => '02:02',
        departure_terminal_id => undef,
        arrival_terminal_id   => undef
    );

    eval {
        $timetable->update();
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
