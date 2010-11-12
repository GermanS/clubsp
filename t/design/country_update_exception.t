use Test::More tests => 2;

use strict;
use warnings;

use_ok('ClubSpain::Design::Country');

#call as class method
{
    eval {
        ClubSpain::Design::Country->update();
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
    my $country = ClubSpain::Design::Country->new(
        id => '777',
        name => 'soviet union',
        alpha2 => 'su',
        alpha3 => 'suu',
        numerics => 777
    );

    eval {
        $country->update();
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
