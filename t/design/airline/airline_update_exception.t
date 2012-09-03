use Test::More tests => 3;
use strict;
use warnings;

use_ok('ClubSpain::Model::Airline');

#call as class method
{
    eval {
        ClubSpain::Model::Airline->update();
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
    my $airline = ClubSpain::Model::Airline->new(
        id           => 777,
        iata         => 'xx',
        icao         => 'udx',
        airline      => 'name',
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
