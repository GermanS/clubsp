use Test::More tests => 3;
use strict;
use warnings;

use_ok('ClubSpain::Model::LocalPhone');

#call as class method
{
    eval {
        ClubSpain::Model::LocalPhone->update();
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
    my $office = ClubSpain::Model::LocalPhone->new(
        id          => 777,
        number      => 1111122222,
        is_published => 0,
    );

    eval {
        $office->update();
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
