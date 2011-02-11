use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::Model::Manufacturer');

{
    eval {
        ClubSpain::Model::Manufacturer->delete(1000);
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
    my $manufacturer = ClubSpain::Model::Manufacturer->new(
        id      => 100,
        code    => 'bar',
        name    => 'foo bar',
    );

    eval {
        $manufacturer->delete();
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

