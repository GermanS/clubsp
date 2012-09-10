use Test::More tests => 7;
use strict;
use warnings;
use lib qw(t/lib);

use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

use_ok('ClubSpain::Model::Customer');

my $employee = ClubSpain::Model::Customer->new(
    name        => 'Jose',
    surname     => 'Cuesta',
    email       => 'info@mail.com',
    passwd      => 'passwd',
    mobile      => '605458224',
    is_published => 1,
);
my $res1 = $employee->create();

my $customer_upd = ClubSpain::Model::Customer->new(
    id          => $res1->id,
    name        => 'Raul',
    surname     => 'Perez',
    email       => 'raul@gmail.com',
    passwd      => 'passwd1',
    mobile      => '625458224',
    is_published => 0,
);

my $object = $customer_upd->update();

is $object->name, 'Raul'
    => 'got name';
is $object->surname, 'Perez'
    => 'got surname';
is $object->email, 'raul@gmail.com'
    => 'got email';
is $object->passwd, 'passwd1'
    => 'got passwd';
is $object->mobile, '625458224'
    => 'got mobile';
is $object->is_published, 0
    => 'got is_published';
