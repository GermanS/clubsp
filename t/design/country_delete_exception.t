use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::Design::Country');

{
    eval {
        ClubSpain::Design::Country->delete(1000);
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('Class method: cought Storage exception');
        } else {
            fail('cought other exception');
            diag $@;
        }
    }
}

{
    my $country = ClubSpain::Design::Country->new(
        id => 100,
        name => 'name',
        alpha2 => 'aa',
        alpha3 => 'aaa',
        numerics => 100,
        is_published => 0,
    );

    eval {
        $country->delete();
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
