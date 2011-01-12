use Test::More tests => 4;

use strict;
use warnings;

use_ok('ClubSpain::Design::Manufacturer');

my $producer = ClubSpain::Design::Manufacturer->new(
    code    => 'code',
    name    => 'name',
);

isa_ok($producer, 'ClubSpain::Design::Manufacturer');
is($producer->code, 'code', 'got manufacturer code');
is($producer->name, 'name', 'got manufacturer name');
