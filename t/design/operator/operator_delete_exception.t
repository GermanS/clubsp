use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::Model::Operator');

{
    eval {
        ClubSpain::Model::Operator->delete(1000);
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
    my $customer = ClubSpain::Model::Operator->new(
        office_id   => 1,
        id          => 23,
        name        => 'Jose',
        surname     => 'Cuesta',
        email       => 'info@mail.com',
        passwd      => 'passwd',
        mobile      => '9054582224',
        is_published => 1,
    );

    eval {
        $customer->delete();
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
