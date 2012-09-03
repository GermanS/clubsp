use Test::More tests => 3;
use strict;
use warnings;

use_ok('ClubSpain::Model::Airplane');

#call as class method
{
    eval {
        ClubSpain::Model::Airplane->update();
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
    my $airplane = ClubSpain::Model::Airplane->new(
        id           => 777,
        manufacturer_id => 1,
        iata         => 'xxx',
        icao         => 'udxx',
        airplane     => 'name',
        is_published => 1,
    );

    eval {
        $airplane->update();
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
