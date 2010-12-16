use Test::More tests => 3;
use strict;
use warnings;

use_ok('ClubSpain::Design::Airport');

#call as class method
{
    eval {
        ClubSpain::Design::Airport->update();
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

#object does not exists in database
{
    my $port = ClubSpain::Design::Airport->new(
        id           => 777,
        city_id      => 100,
        iata         => 'xxx',
        icao         => 'uudx',
        name         => 'name',
        is_published => 1,
    );

    eval {
        $port->update();
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
