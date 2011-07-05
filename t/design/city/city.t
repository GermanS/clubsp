use Test::More tests => 7;

use strict;
use warnings;

use_ok('ClubSpain::Model::City');

my $city = ClubSpain::Model::City->new(
    country_id      => 1,
    iata            => 'VOG',
    name            => 'Volgograd',
    name_ru         => 'Волгоград',
    is_published    => 1,
);


isa_ok($city, 'ClubSpain::Model::City');
is($city->country_id, 1, 'got country_id');
is($city->iata, 'VOG', 'got iata code');
is($city->name, 'Volgograd', 'got name');
is($city->name_ru, 'Волгоград', 'got ru name');
is($city->is_published, 1, 'got header');
