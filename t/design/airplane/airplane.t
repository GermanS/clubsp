use Test::More tests => 7;

use strict;
use warnings;

use_ok('ClubSpain::Model::Airplane');

my $airplane = ClubSpain::Model::Airplane->new(
    iata => '310',
    icao => 'A310',
    name => 'A310',
    manufacturer_id => 1,
    is_published    => 1,
);

isa_ok($airplane, 'ClubSpain::Model::Airplane');
is $airplane->get_manufacturer_id, 1
    => 'got manufacturer';
is $airplane->get_iata, '310'
    => 'got iata code';
is $airplane->get_icao, 'A310'
    => 'got icao code';
is $airplane->get_name, 'A310'
    => 'got name';
is $airplane->get_is_published, 1
    => 'got is published';
