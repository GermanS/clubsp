use Test::More tests => 8;

use strict;
use warnings;

use_ok('ClubSpain::Model::Customer');

my $customer = ClubSpain::Model::Customer->new(
    name    => 'Иван',
    surname => 'Иванов',
    email   => 'ivan@ivanov.ru',
    passwd  => 'passwd',
    mobile  => '79851234567',
    is_published => 1,
);


isa_ok($customer, 'ClubSpain::Model::Customer');
is($customer->name, 'Иван', 'got name');
is($customer->surname, 'Иванов', 'got surname');
is($customer->email, 'ivan@ivanov.ru', 'got email');
is($customer->passwd, 'passwd', 'got passwd');
is($customer->mobile, '79851234567', 'got mobile');
is($customer->is_published, 1, 'got is published');
