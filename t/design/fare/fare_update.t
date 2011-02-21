use Test::More tests => 4;
use strict;
use warnings;
use lib qw(t/lib);
use ClubSpain::Test;
ClubSpain::Test->init_schema();

use_ok('ClubSpain::Model::Fare');

my $fare = ClubSpain::Model::Fare->new(
    id      => 1,
    fare    => 99,
);

my $result = $fare->update();

isa_ok($result, 'ClubSpain::Schema::Result::Fare');
is($result->id, 1, 'got id');
is($result->fare, 99, 'got fare');
