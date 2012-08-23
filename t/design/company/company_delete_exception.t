use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::Model::Company');

{
    eval {
        ClubSpain::Model::Company->delete(1000);
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
    my $company = ClubSpain::Model::Company->new(
        id      => 999,
        zipcode => 129345,
        street  => 'ivana babushkina 16',
        name    => 'aviabroker.com',
        nick    => 'aviabroker.com',
        website => 'somewhere.com',
        INN     => 123456789021,
        OKPO    => 3234567890,
        OKVED   => 4234567890,
        is_published => 1
    );

    eval {
        $company->delete();
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
