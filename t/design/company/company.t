use Test::More tests => 15;

use strict;
use warnings;

use_ok('ClubSpain::Model::Company');

my $company = ClubSpain::Model::Company->new(
    name => 'name',
    nick => 'nick',
    INN  => 1234567890123,
    OGRN => 1234567890,
    KPP  => 2234567890,
    OKPO => 3234567890,
    OKVED=> 4234567890,
    OKATO=> 5234567890,
    OKTMO=> 6234567890,
    OKOGU=> 7234567890,
    OKFS => 8234567890,
    OKPF => 9234567890,
    is_published => 1,
);

isa_ok($company, 'ClubSpain::Model::Company');
is $company->name, 'name'
    => 'got name';
is $company->nick, 'nick'
    => 'got nickname';
is $company->INN, 1234567890123
    => 'got INN';
is $company->OGRN, 1234567890
    => 'got OGRN';
is $company->KPP, 2234567890
    => 'got KPP';
is $company->OKPO, 3234567890
    => 'got OKPO';
is $company->OKVED, 4234567890
    => 'got OKVED';
is $company->OKATO, 5234567890
    => 'got OKATO';
is $company->OKTMO, 6234567890
    => 'got OKTMO';
is $company->OKOGU, 7234567890
    => 'got OKOGU';
is $company->OKFS, 8234567890
    => 'got OKFS';
is $company->OKPF, 9234567890
    => 'got OKPF';
is $company->is_published, 1
    => 'got is_published';
