use Test::More tests => 3;
use strict;
use warnings;

use_ok('ClubSpain::Design::FareClass');

#call as class method
{
    eval {
        ClubSpain::Design::FareClass->update();
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
    my $fareclass = ClubSpain::Design::FareClass->new(
        id           => 777,
        code         => 'u',
        name         => 'name',
        is_published => 1,
    );

    eval {
        $fareclass->update();
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
