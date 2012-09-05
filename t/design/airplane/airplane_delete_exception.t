use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::Model::Airplane');

{
    eval {
        ClubSpain::Model::Airplane->delete(1000);
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
    my $airplane = ClubSpain::Model::Airplane->new(
        id   => 23,
        iata => 'foo',
        icao => 'barx',
        name => 'foo barx',
        manufacturer_id => 1,
        is_published    => 0,
    );

    eval {
        $airplane->delete();
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
