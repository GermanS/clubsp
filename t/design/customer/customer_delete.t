use Test::More tests => 9;

use strict;
use warnings;

use_ok('ClubSpain::Model::Customer');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();
my $schema = $helper->schema();
my $count = $schema->resultset('Customer')->search({})->count;

my $customer = ClubSpain::Model::Customer->new(
    name        => 'Jose',
    surname     => 'Cuesta',
    email       => 'info@mail.com',
    passwd      => 'passwd',
    mobile      => '9054582224',
    is_published => 1,
);

my $object = $customer->create();

isa_ok($object, 'ClubSpain::Schema::Result::Customer');
is $object->name, 'Jose',
    => 'got name';
is $object->surname, 'Cuesta'
    => 'got surname';
is $object->email, 'info@mail.com'
    => 'got email';
is $object->passwd, 'passwd'
    => 'got passwd';
is $object->mobile, '9054582224'
    => 'got mobile';
is $object->is_published, 1
    => 'got is_published';


ClubSpain::Model::Customer->delete($object->id);

my $rs = $schema->resultset('Customer')->search({});
is($rs->count, $count, 'no objects left');
