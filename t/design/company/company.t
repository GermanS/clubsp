use Test::More tests => 12;

use strict;
use warnings;

use_ok('ClubSpain::Model::Company');

my $company = ClubSpain::Model::Company->new(
    zipcode => 123456,
    street  => 'calle de colomn 4',
    name    => 'origin name',
    nick    => 'brand name',
    website => 'somewhere.com',
    INN     => 7702581366,
    OKPO    => 79011171,
    OKVED   => 4234567890,
    is_NDS  => 1,
    is_published => 1,
);

isa_ok($company, 'ClubSpain::Model::Company');
is $company->get_zipcode, 123456,
    'got zipcode';
is $company->get_street, 'calle de colomn 4',
    'got street name';
is $company->get_name, 'origin name'
    => 'got name';
is $company->get_nick, 'brand name'
    => 'got nickname';
is $company->get_website, 'somewhere.com',
    => 'got website';
is $company->get_INN, 7702581366
    => 'got INN';
is $company->get_OKPO, 79011171
    => 'got OKPO';
is $company->get_OKVED, 4234567890
    => 'got OKVED';
is $company->get_is_NDS, 1
    => 'got is_NDS';
is $company->get_is_published, 1
    => 'got is_published';

