use Test::More tests => 3;
use strict;
use warnings;

use_ok('ClubSpain::Model::Fare');

#call as class method
{
    eval {
        ClubSpain::Model::Fare->update();
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
    my $fare = ClubSpain::Model::Fare->new(
        id   => 777,
        fare => 0
    );

    eval {
        $fare->update();
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
