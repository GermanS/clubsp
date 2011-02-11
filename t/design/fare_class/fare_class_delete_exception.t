use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::Model::FareClass');

{
    eval {
        ClubSpain::Model::FareClass->delete(1000);
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
    my $fareclass = ClubSpain::Model::FareClass->new(
        id      => 23,
        code    => 'w',
        name    => 'foo bar',
        is_published=> 0,
    );

    eval {
        $fareclass->delete();
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
