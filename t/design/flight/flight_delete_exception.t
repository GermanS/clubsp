use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::Model::Flight');

{
    eval {
        ClubSpain::Model::Flight->delete(1000);
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
    my $airline = ClubSpain::Model::Flight->new(
        id                      => 456,
        is_published            => 0,
        airport_of_departure    => 1,
        airport_of_arrival      => 2,
        airline_id              => 1,
        code                    => 8331,
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
