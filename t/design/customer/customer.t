use Test::More tests => 8;

use strict;
use warnings;

use_ok('ClubSpain::Model::Customer');

my $params = {
    name    => 'Иван',
    surname => 'Иванов',
    email   => 'ivan@ivanov.ru',
    passwd  => 'passwd',
    mobile  => 9851234567,
    is_published => 1,
};
my $customer = ClubSpain::Model::Customer->new( $params );


isa_ok($customer, 'ClubSpain::Model::Customer');
is $customer->get_name, $params->{'name'}
    => 'got name';
is $customer->get_surname, $params->{'surname'}
    => 'got surname';
is $customer->get_email, $params->{'email'}
    => 'got email';
is $customer->get_passwd, $params->{'passwd'}
    => 'got passwd';
is $customer->get_mobile, $params->{'mobile'}
    => 'got mobile';
is $customer->get_is_published, $params->{'is_published'}
    => 'got is published';
