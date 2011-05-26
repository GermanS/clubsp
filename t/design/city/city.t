use Test::More tests => 6;

use strict;
use warnings;

use_ok('ClubSpain::Model::City');

my $city = ClubSpain::Model::City->new(
    country_id      => 1,
    iata            => 'VOG',
    name            => 'Volgograd',
    is_published    => 1,
);


isa_ok($city, 'ClubSpain::Model::City');
is($city->country_id, 1, 'got country_id');
is($city->iata, 'VOG', 'got iata code');
is($city->name, 'Volgograd', 'got name');
is($city->is_published, 1, 'got header');
