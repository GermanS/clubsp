use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::Model::TimeTable');

{
    eval {
        ClubSpain::Model::TimeTable->delete(1000);
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
    my $terminal = ClubSpain::Model::TimeTable->new(
        id          => 23,
        is_published      => 1,
        flight_id         => 1,
        airplane_id       => 1,
        departure_date    => '2011-01-21',
        departure_time    => '20:30',
        arrival_date      => '2011-01-22',
        arrival_time      => '01:20',
        departure_terminal_id => undef,
        arrival_terminal_id   => undef
    );

    eval {
        $terminal->delete();
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
