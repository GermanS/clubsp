use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::Model::Office');

{
    eval {
        ClubSpain::Model::Office->delete(1000);
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
    my $office = ClubSpain::Model::Office->new(
        id          => 100,
        company_id  => 1,
        zipcode     => 123456,
        street      => 'Babushkinskaya 7',
        name        => 'central office',
        is_published => 1,
    );

    eval {
        $office->delete();
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
