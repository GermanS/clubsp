use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::Model::LocalPhone');

{
    eval {
        ClubSpain::Model::LocalPhone->delete(1000);
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
    my $airline = ClubSpain::Model::LocalPhone->new(
        id          => 23,
        office_id   => 1,
        number      => 8889991112,
        is_published=> 0,
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
