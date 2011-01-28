use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::Model::City');

{
    eval {
        ClubSpain::Model::City->delete(1000);
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
    my $city = ClubSpain::Model::City->new(
        id => 100,
        country_id => 1,
        name => 'name',
        is_published => 0,
    );

    eval {
        $city->delete();
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
