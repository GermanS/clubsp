use Test::More tests => 3;
use strict;
use warnings;

use_ok('ClubSpain::Model::BankAccount');

#call as class method
{
    eval {
        ClubSpain::Model::BankAccount->update();
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
    my $account = ClubSpain::Model::BankAccount->new(
        id          => 777,
        company_id  => 1,
        bank        => 'PSBank',
        BIC         => '047654001',
        current_account       => '12345678901234567890',
        correspondent_account => '12345678901234567890',
        is_published => 0
    );

    eval {
        $account->update();
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
