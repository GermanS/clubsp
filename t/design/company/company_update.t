use Test::More tests => 12;
use strict;
use warnings;
use lib qw(t/lib);

use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

use_ok('ClubSpain::Model::Company');

my $first = ClubSpain::Model::Company->new(
    zipcode => 123456,
    street  => 'calle de colomn 4',
    name    => 'origin name',
    nick    => 'brand name',
    website => 'somewhere.com',
    INN     => 1234567890123,
    OKPO    => 3234567890,
    OKVED   => 4234567890,
    is_NDS  => 1,
    is_published => 1
);
my $res = $first->create();

my $company = ClubSpain::Model::Company->new(
    id      => $res->id,
    zipcode => 123000,
    street  => 'calle de colomn 4 upd',
    name    => 'origin name upd',
    nick    => 'brand name upd',
    website => 'somewhere.com',
    INN     => 1234567890000,
    OKPO    => 3234567000,
    OKVED   => 4234567000,
    is_NDS  => 1,
    is_published => 1
);

my $result = $company->update();

isa_ok($result, 'ClubSpain::Schema::Result::Company');
is $company->zipcode, 123000
    => 'got zipcode';
is $company->street, 'calle de colomn 4 upd'
    => 'got street';
is $company->name, 'origin name upd'
    => 'origin name';
is $company->nick, 'brand name upd'
    => 'brand name';
is $company->website, 'somewhere.com'
    => 'got website';
is $company->INN, 1234567890000
    => 'got INN';
is $company->OKPO, 3234567000
    => 'got OKPO';
is $company->OKVED, 4234567000
    => 'got OKVED';
is $company->is_NDS, 1
    => 'got is_NDS';
is $company->is_published, 1
    => 'got is_published';
