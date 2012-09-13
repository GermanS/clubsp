use Test::More tests => 9;
use strict;
use warnings;

use_ok('ClubSpain::Model::BankAccount');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();
my $schema = $helper->schema();
my $count = $schema->resultset('BankAccount')->search({})->count;

my $params = {
    company_id => 1,
    bank => 'gazneftbank',
    BIC  => '044585297',
    current_account => '40702810900000005219',
    correspondent_account => '30101810500000000297',
    is_published => 0
};

my $account = ClubSpain::Model::BankAccount->new( $params );

my $object = $account->create();

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
is $object->is_published, 0, 'got is published';


ClubSpain::Model::BankAccount->delete($object->id);

my $rs = $schema->resultset('BankAccount')->search({});
is($rs->count, $count, 'no objects left');
