use Test::More tests => 3;
use strict;
use warnings;

use_ok('ClubSpain::Design::Terminal');

#call as class method
{
    eval {
        ClubSpain::Design::Terminal->update();
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
    my $terminal = ClubSpain::Design::Terminal->new(
        id           => 777,
        airport_id   => 1,
        name         => 'name',
        is_published => 1,
    );

    eval {
        $terminal->update();
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
