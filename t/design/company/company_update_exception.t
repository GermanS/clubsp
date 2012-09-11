use Test::More tests => 3;
use strict;
use warnings;

use_ok('ClubSpain::Model::Company');

#call as class method
{
    eval {
        ClubSpain::Model::Company->update();
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
    my $company = ClubSpain::Model::Company->new(
        id      => 999,
        zipcode => 123456,
        street  => 'calle de colomn 4',
        name    => 'origin name',
        nick    => 'brand name',
        website => 'somewhere.com',
        INN     => 673002363905,
        OKPO    => 7901117001,
        OKVED   => 4234567890,
        is_NDS  => 1,
        is_published => 1
    );

    eval {
        $company->update();
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
