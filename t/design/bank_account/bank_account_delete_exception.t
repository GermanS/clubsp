use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::Model::BankAccount');

{
    eval {
        ClubSpain::Model::BankAccount->delete(1000);
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
    my $account = ClubSpain::Model::BankAccount->new(
        id => 99,
        company_id => 1,
        bank => 'gazneftbank',
        BIC  => '044585297',
        current_account => '40702810900000005219',
        correspondent_account => '30101810500000000297',
    );

    eval {
        $account->delete();
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
