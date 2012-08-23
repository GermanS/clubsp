use Test::More tests => 11;

use strict;
use warnings;

use_ok('ClubSpain::Model::Company');

my $company = ClubSpain::Model::Company->new(
    zipcode => 123456,
    street  => 'calle de colomn 4',
    name    => 'origin name',
    nick    => 'brand name',
    website => 'somewhere.com',
    INN     => 1234567890123,
    OKPO    => 3234567890,
    OKVED   => 4234567890,
    is_published => 1
);

isa_ok($company, 'ClubSpain::Model::Company');
is $company->zipcode, 123456,
    'got zipcode';
is $company->street, 'calle de colomn 4',
    'got street name';
is $company->name, 'origin name'
    => 'got name';
is $company->nick, 'brand name'
    => 'got nickname';
is $company->website, 'somewhere.com',
    => 'got website';
is $company->INN, 1234567890123
    => 'got INN';
is $company->OKPO, 3234567890
    => 'got OKPO';
is $company->OKVED, 4234567890
    => 'got OKVED';
is $company->is_published, 1
    => 'got is_published';
