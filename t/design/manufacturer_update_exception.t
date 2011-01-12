use Test::More tests => 3;
use strict;
use warnings;

use_ok('ClubSpain::Design::Manufacturer');

#call as class method
{
    eval {
        ClubSpain::Design::Manufacturer->update();
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

#object does not exists in database
{
    my $manufacturer = ClubSpain::Design::Manufacturer->new(
        id           => 777,
        code         => 'code',
        name         => 'name',
    );

    eval {
        $manufacturer->update();
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
