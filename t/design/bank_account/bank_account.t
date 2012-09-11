use Test::More tests => 6;
use strict;
use warnings;
use utf8;

use_ok('ClubSpain::Model::BankAccount');

my $params = {
    company_id => 1,
    bank => 'gazneftbank',
    BIC  => '044585297',
    current_account => '40702810900000005219',
    correspondent_account => '30101810500000000297',
};
my $account = ClubSpain::Model::BankAccount->new($params);
isa_ok($account, 'ClubSpain::Model::BankAccount');
is $account->get_company_id, $params->{'company_id'}
    => 'got company';
is $account->get_bank, $params->{'bank'}
    => 'got name of the bank';
is $account->get_BIC, $params->{'BIC'}
    => 'got bic';
is $account->get_current_account, $params->{'current_account'}
    => 'got bank account';
is $account->get_correspondent_account, $params->{'correspondent_account'}
    => 'got correspondent account';
