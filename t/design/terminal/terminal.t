use Test::More tests => 5;

use strict;
use warnings;

use_ok('ClubSpain::Model::Terminal');

my $airline = ClubSpain::Model::Terminal->new(
    airport_id  => 1,
    name        => 'Sector A',
    is_published => 1,
);

isa_ok($airline, 'ClubSpain::Model::Terminal');
is $airline->get_airport_id, 1
    => 'got airport id';
is $airline->get_name, 'Sector A'
    => 'got name';
is $airline->get_is_published, 1
    => 'got is published';
