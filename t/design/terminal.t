use Test::More tests => 5;

use strict;
use warnings;

use_ok('ClubSpain::Design::Terminal');

my $airline = ClubSpain::Design::Terminal->new(
    airport_id  => 1,
    name        => 'Sector A',
    is_published => 1,
);


isa_ok($airline, 'ClubSpain::Design::Terminal');
is($airline->airport_id, 1, 'got airport id');
is($airline->name, 'Sector A', 'got name');
is($airline->is_published, 1, 'got is published');
