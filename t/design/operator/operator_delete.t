use Test::More tests => 10;

use strict;
use warnings;

use_ok('ClubSpain::Model::Operator');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();
my $schema = $helper->schema();
my $count = $schema->resultset('Operator')->search({})->count;

my $operator = ClubSpain::Model::Operator->new(
    office_id   => 1,
    name        => 'Jose',
    surname     => 'Cuesta',
    email       => 'info@mail.com',
    passwd      => 'passwd',
    mobile      => '9054582224',
    is_published => 1,
);

my $object = $operator->create();

isa_ok($object, 'ClubSpain::Schema::Result::Operator');
is $object->office_id, 1
    => 'got office id';
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


ClubSpain::Model::Operator->delete($object->id);

my $rs = $schema->resultset('Operator')->search({});
is($rs->count, $count, 'no objects left');
