use Test::More tests => 3;
use strict;
use warnings;

use_ok('ClubSpain::Model::Flight');

#call as class method
{
    eval {
        ClubSpain::Model::Flight->update();
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
    my $flight = ClubSpain::Model::Flight->new(
        id => 777,
        is_published => 1,
        airport_of_departure => 1,
        airport_of_arrival => 2,
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
