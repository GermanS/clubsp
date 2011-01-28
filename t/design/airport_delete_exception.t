use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::Model::Airport');

{
    eval {
        ClubSpain::Model::Airport->delete(1000);
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
    my $port = ClubSpain::Model::Airport->new(
        id      => 100,
        city_id => 1,
        iata    => 'bar',
        icao    => 'barx',
        name    => 'foo bar',
        is_published=> 0,
    );

    eval {
        $port->delete();
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

