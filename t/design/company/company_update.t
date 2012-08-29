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
    company => 'origin name',
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
    company => 'origin name upd',
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
is $result->zipcode, 123000
    => 'got zipcode';
is $result->street, 'calle de colomn 4 upd'
    => 'got street';
is $result->company, 'origin name upd'
    => 'origin name';
is $result->nick, 'brand name upd'
    => 'brand name';
is $result->website, 'somewhere.com'
    => 'got website';
is $result->INN, 1234567890000
    => 'got INN';
is $result->OKPO, 3234567000
    => 'got OKPO';
is $result->OKVED, 4234567000
    => 'got OKVED';
is $result->is_NDS, 1
    => 'got is_NDS';
is $result->is_published, 1
    => 'got is_published';
