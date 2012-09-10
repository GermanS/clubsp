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
is $customer->get_name, 'Иван'
    => 'got name';
is $customer->get_surname, 'Иванов'
    => 'got surname';
is $customer->get_email, 'ivan@ivanov.ru'
    => 'got email';
is $customer->get_passwd, 'passwd'
    => 'got passwd';
is $customer->get_mobile, '79851234567'
    => 'got mobile';
is $customer->get_is_published, 1
    => 'got is published';
