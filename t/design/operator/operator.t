use Test::More tests => 9;

use strict;
use warnings;

use_ok('ClubSpain::Model::Operator');

my $params = {
    office_id => 1,
    name    => 'Иван',
    surname => 'Иванов',
    email   => 'ivan@ivanov.ru',
    passwd  => 'passwd',
    mobile  => 9851234567,
    is_published => 1,
};
my $operator = ClubSpain::Model::Operator->new( $params );


isa_ok($operator, 'ClubSpain::Model::Operator');
is $operator->get_office_id, $params->{'office_id'}
    => 'got office id';
is $operator->get_name, $params->{'name'}
    => 'got name';
is $operator->get_surname, $params->{'surname'}
    => 'got surname';
is $operator->get_email, $params->{'email'}
    => 'got email';
is $operator->get_passwd, $params->{'passwd'}
    => 'got passwd';
is $operator->get_mobile, $params->{'mobile'}
    => 'got mobile';
is $operator->get_is_published, $params->{'is_published'}
    => 'got is published';
