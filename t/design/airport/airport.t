use Test::More tests => 7;

use strict;
use warnings;

use_ok('ClubSpain::Model::Airport');

my $port = ClubSpain::Model::Airport->new(
    iata => 'dme',
    icao => 'uudm',
    name => 'Domodedovo',
    city_id      => 1,
    is_published => 1,
);

isa_ok($port, 'ClubSpain::Model::Airport');
is $port->get_city_id, 1,
    => 'got city_id';
is $port->get_iata, 'dme'
    => 'got iata code';
is $port->get_icao, 'uudm'
    => 'got icao code';
is $port->get_name, 'Domodedovo'
    => 'got name';
is $port->get_is_published, 1
    => 'got header';
