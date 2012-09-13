use Test::More tests => 3;
use strict;
use warnings;

use_ok('ClubSpain::Model::Office');

#call as class method
{
    eval {
        ClubSpain::Model::Office->update();
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
    my $office = ClubSpain::Model::Office->new(
        id          => 777,
        zipcode     => 654321,
        street      => 'Address 22',
        name        => 'Office 3',
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
