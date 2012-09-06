use Test::More tests => 4;

use strict;
use warnings;

use_ok('ClubSpain::Model::Manufacturer');

my $producer = ClubSpain::Model::Manufacturer->new(
    code    => 'code',
    name    => 'name',
);

isa_ok($producer, 'ClubSpain::Model::Manufacturer');
is $producer->get_code, 'code'
    => 'got manufacturer code';
is $producer->get_name, 'name'
    => 'got manufacturer name';
