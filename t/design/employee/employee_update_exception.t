use Test::More tests => 3;
use strict;
use warnings;

use_ok('ClubSpain::Model::Employee');

#call as class method
{
    eval {
        ClubSpain::Model::Employee->update();
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
    my $employee = ClubSpain::Model::Employee->new(
        id           => 777,
        name         => 'foo',
        surname      => 'bar',
        email        => 'baz@foo.bar',
        password     => 'pass',
        is_published => 1,
    );

    eval {
        $employee->update();
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
