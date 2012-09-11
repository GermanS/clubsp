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
    INN     => 7702581366,
    OKPO    => 79011171,
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
    INN     => 673002363905,
    OKPO    => 7901117001,
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
is $result->name, 'origin name upd'
    => 'origin name';
is $result->nick, 'brand name upd'
    => 'brand name';
is $result->website, 'somewhere.com'
    => 'got website';
is $result->INN, 673002363905
    => 'got INN';
is $result->OKPO, 7901117001
    => 'got OKPO';
is $result->OKVED, 4234567000
    => 'got OKVED';
is $result->is_NDS, 1
    => 'got is_NDS';
is $result->is_published, 1
    => 'got is_published';
