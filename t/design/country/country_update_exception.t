use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::Model::Country');

#call as class method
{
    eval {
        ClubSpain::Model::Country->update();
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
    my $country = ClubSpain::Model::Country->new(
        id => '777',
        name    => 'soviet union',
        alpha2  => 'su',
        alpha3  => 'suu',
        numerics => 777,
        is_published => 1,
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
