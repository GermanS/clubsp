use Test::More tests => 4;

use strict;
use warnings;

use_ok('ClubSpain::Model::Manufacturer');

my $producer = ClubSpain::Model::Manufacturer->new(
    code    => 'code',
    name    => 'name',
);

isa_ok($producer, 'ClubSpain::Model::Manufacturer');
is($producer->code, 'code', 'got manufacturer code');
is($producer->name, 'name', 'got manufacturer name');
