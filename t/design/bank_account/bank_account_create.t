use Test::More tests => 8;
use strict;
use warnings;

use_ok('ClubSpain::Model::BankAccount');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

#first insert
{
    my $params = {
        company_id  => 1,
        bank        => 'PSBank',
        BIC         => '044585297',
        current_account       => '40702810900000005219',
        correspondent_account => '30101810500000000297'
    };

    my $account = ClubSpain::Model::BankAccount->new( $params );

    my $result;

    eval {
        $result = $account->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Result::BankAccount');
    is $result->company_id, $params->{'company_id'}
        => 'got company id';
    is $result->bank, $params->{'bank'}
        => 'got bank';
    is $result->BIC, $params->{'BIC'}
        => 'got bank identifier code';
    is $result->current_account, $params->{'current_account'}
        => 'got current account';
    is $result->correspondent_account, $params->{'correspondent_account'}
        => 'got correspondent account';
}
