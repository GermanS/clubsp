use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::Design::Airline');

{
    eval {
        ClubSpain::Design::Airline->delete(1000);
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
    my $airline = ClubSpain::Design::Airline->new(
        id      => 23,
        iata    => 'fo',
        icao    => 'bar',
        name    => 'fo bar',
        is_published=> 0,
    );

    eval {
        $airline->delete();
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
