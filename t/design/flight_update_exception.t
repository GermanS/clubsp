use Test::More tests => 3;
use strict;
use warnings;

use_ok('ClubSpain::Design::Flight');

#call as class method
{
    eval {
        ClubSpain::Design::Flight->update();
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
    my $flight = ClubSpain::Design::Flight->new(
        id => 777,
        departure_airport_id => 1,
        destination_airport_id => 2,
        airline_id => 1,
        code => 123,
    );

    eval {
        $flight->update();
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
