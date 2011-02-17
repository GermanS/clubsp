use Test::More tests => 4;

use strict;
use warnings;

use_ok('ClubSpain::Model::Fare');

my $fare = ClubSpain::Model::Fare->new(
    fare          => 1000,
);

isa_ok($fare, 'ClubSpain::Model::Fare');
is($fare->fare, 1000, 'got price');
