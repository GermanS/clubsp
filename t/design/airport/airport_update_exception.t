use Test::More tests => 3;
use strict;
use warnings;

use_ok('ClubSpain::Model::Airport');

#call as class method
{
    eval {
        ClubSpain::Model::Airport->update();
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
    my $port = ClubSpain::Model::Airport->new(
        id   => 777,
        iata => 'xxx',
        icao => 'uudx',
        name => 'name',
        city_id      => 100,
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
