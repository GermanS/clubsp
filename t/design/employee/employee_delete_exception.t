use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::Model::Employee');

{
    eval {
        ClubSpain::Model::Employee->delete(1000);
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
    my $employee = ClubSpain::Model::Employee->new(
        id      => 23,
        name    => 'foo',
        surname => 'bar',
        email   => 'foo@bar.com',
        password => 'baz',
        is_published=> 0,
    );

    eval {
        $employee->delete();
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
