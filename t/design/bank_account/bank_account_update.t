use Test::More tests => 9;
use strict;
use warnings;
use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

use_ok('ClubSpain::Model::BankAccount');
#add account to database
{
    my $account = ClubSpain::Model::BankAccount->new(
        company_id => 1,
        bank => 'PSBank',
        BIC  => '047654001',
        current_account       => '12345678901234567890',
        correspondent_account => '12345678901234567890',
        is_published => 0
    );
    $account->create();
}

my $params = {
    id   => 1,
    company_id => 1,
    bank => 'gazneftbank',
    BIC  => '044585297',
    current_account => '40702810900000005219',
    correspondent_account => '30101810500000000297',
    is_published => 0
};

my $account = ClubSpain::Model::BankAccount->new( $params );
my $result = $account->update();

isa_ok($result, 'ClubSpain::Schema::Result::BankAccount');
is $result->id, $params->{'id'}
    => 'got id';
is $result->company_id, $params->{'company_id'}
    => 'got company id';
is $result->bank, $params->{'bank'}
    => 'got bank';
is $result->BIC, $params->{'BIC'}
    => 'got BIC';
is $result->current_account, $params->{'current_account'}
    => 'got current account';
is $result->correspondent_account, $params->{'correspondent_account'}
    => 'got correspondent account';
is $result->is_published, 0
    => 'got is_published';
