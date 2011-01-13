use Test::More tests => 3;
use strict;
use warnings;

use_ok('ClubSpain::Design::Airline');

#call as class method
{
    eval {
        ClubSpain::Design::Airline->update();
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
    my $airline = ClubSpain::Design::Airline->new(
        id           => 777,
        iata         => 'xx',
        icao         => 'udx',
        name         => 'name',
        is_published => 1,
    );

    eval {
        $airline->update();
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
