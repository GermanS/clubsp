use Test::More tests => 4;

use strict;
use warnings;

use_ok('ClubSpain::Model::Fare');

my $fare = ClubSpain::Model::Fare->new(
    is_published  => 1,
    fare          => 1000,
);

isa_ok($fare, 'ClubSpain::Model::Fare');
is($fare->is_published, 1, 'got is published');
is($fare->fare, 1000, 'got price');
