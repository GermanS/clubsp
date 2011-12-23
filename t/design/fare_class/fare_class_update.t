use Test::More tests => 6;
use strict;
use warnings;
use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

use_ok('ClubSpain::Model::FareClass');

my $fareclass = ClubSpain::Model::FareClass->new(
    id          => 1,
    code        => 'R',
    name        => 'New FareClass name',
    is_published=> 0,
);

my $result = $fareclass->update();

isa_ok($result, 'ClubSpain::Schema::Result::FareClass');
is($result->id, 1, 'got id');
is($result->code, 'R', 'got code');
is($result->name, 'New FareClass name', 'got name');
is($result->is_published, 0, 'got is_published');
