use Test::More tests => 6;
use strict;
use warnings;
use_ok('ClubSpain::Model::Airline');

my $airline = ClubSpain::Model::Airline->new(
    iata => 'S7',
    icao => 'SBI',
    name => 'S7 Airlines',
    is_published => 1,
);

isa_ok($airline, 'ClubSpain::Model::Airline');
is $airline->get_iata, 'S7'
    => 'got iata code';
is $airline->get_icao, 'SBI'
    => 'got icao code';
is $airline->get_name, 'S7 Airlines'
    => 'got name';
is $airline->get_is_published, 1
    => 'got is published';
