use Test::More tests => 7;

use strict;
use warnings;

use_ok('ClubSpain::Model::City');

my $city = ClubSpain::Model::City->new(
    country_id      => 1,
    iata            => 'VOG',
    name_en         => 'Volgograd',
    name_ru         => 'Волгоград',
    is_published    => 1,
);


isa_ok($city, 'ClubSpain::Model::City');
is $city->get_country_id, 1
    => 'got country_id';
is $city->get_iata, 'VOG'
    => 'got iata code';
is $city->get_name_en, 'Volgograd'
    => 'got name';
is $city->get_name_ru, 'Волгоград'
    => 'got ru name';
is $city->get_is_published, 1
    => 'got header';
