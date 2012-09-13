use Test::More tests => 19;

use strict;
use warnings;

use_ok('ClubSpain::Model::BankAccount');

use lib qw(t/lib);
use ClubSpain::Test;

my $helper = ClubSpain::Test->new();
my $params = {
    company_id => 1,
    bank => 'gazneftbank',
    BIC  => '044585297',
    current_account => '40702810900000005219',
    correspondent_account => '30101810500000000297',
    is_published => 0
};
my $account = ClubSpain::Model::BankAccount->new( $params );
my $init_object  = $account->create();

#pass id to the function
{
    my $object = ClubSpain::Model::BankAccount->fetch_by_id($init_object->id);
    isa_ok($object, 'ClubSpain::Schema::Result::BankAccount');
    is $object->company_id, $params->{'company_id'}
        => 'got company id';
    is $object->bank, $params->{'bank'}
        => 'got bank';
    is $object->BIC, $params->{'BIC'}
        => 'got BIC';
    is $object->current_account, $params->{'current_account'}
        => 'got current account';
    is $object->correspondent_account, $params->{'correspondent_account'}
        => 'got correspondent account';
    is $object->is_published, $params->{'is_published'}
        => 'got is published';
}


#retrive
{
    $account->set_id(1);
    my $object = $account->fetch_by_id();

    isa_ok($object, 'ClubSpain::Schema::Result::BankAccount');
    is $object->company_id, $params->{'company_id'}
        => 'got company id';
    is $object->bank, $params->{'bank'}
        => 'got bank';
    is $object->BIC, $params->{'BIC'}
        => 'got BIC';
    is $object->current_account, $params->{'current_account'}
        => 'got current account';
    is $object->correspondent_account, $params->{'correspondent_account'}
        => 'got correspondent account';
    is $object->is_published, $params->{'is_published'}
        => 'got is published';
}

#exception
{
    eval {
        ClubSpain::Model::BankAccount->fetch_by_id(1000);
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find BankAccount: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}

#exception
{
    $account->set_id(1000);

    eval {
        $account->fetch_by_id();
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find BankAccount: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}
