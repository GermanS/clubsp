use Test::More tests => 7;

use strict;
use warnings;

use_ok('ClubSpain::Model::Company');

my $company = ClubSpain::Model::Company->new(
    name => 'name',
    nick => 'nickname',
    INN  => 1234567890123,
    OGRN => 1234567890,
    KPP  => 2234567890,
    OKPO => 3234567890,
    OKVED=> 5234567890,
    OKATO=> 4234567890,
    OKTMO=> 6234567890,
    OKOGU=> 7234567890,
    OKFS => 8234567890,
    OKPF => 9234567890,
);


isa_ok($company, 'ClubSpain::Model::Company');
is $company->name,
    'name', 'got name';



