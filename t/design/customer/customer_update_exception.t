use Test::More tests => 3;
use strict;
use warnings;

use_ok('ClubSpain::Model::Customer');

#call as class method
{
    eval {
        ClubSpain::Model::Customer->update();
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
    my $customer = ClubSpain::Model::Customer->new(
        id           => 777,
        name        => 'Jose',
        surname     => 'Cuesta',
        email       => 'info@mail.com',
        passwd      => 'passwd',
        mobile      => '605458224',
        is_published => 1,
    );

    eval {
        $customer->update();
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
