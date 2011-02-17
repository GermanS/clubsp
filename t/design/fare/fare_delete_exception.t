use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::Model::Fare');

{
    eval {
        ClubSpain::Model::Fare->delete(1000);
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
    my $fare = ClubSpain::Model::Fare->new(
        id     => 23,
        fare   =>100
    );

    eval {
        $fare->delete();
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
