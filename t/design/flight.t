use Test::More tests => 11;

use strict;
use warnings;

use_ok('ClubSpain::Model::Flight');

{
    my $flight = ClubSpain::Model::Flight->new(
        departure_airport_id    => 1,
        destination_airport_id  => 2,
        airline_id              => 1,
        code                    => 331,
    );


    isa_ok($flight, 'ClubSpain::Model::Flight');
    is($flight->departure_airport_id, 1, 'got departure airport id');
    is($flight->destination_airport_id, 2, 'got destination airport id');
    is($flight->airline_id, 1, 'got airline');
    is($flight->code, 331, 'got code');
}

{
    my $flight = ClubSpain::Model::Flight->new(
        departure_airport_id    => 1,
        destination_airport_id  => 2,
        airline_id              => 1,
        code                    => 331,
    );


    isa_ok($flight, 'ClubSpain::Model::Flight');
    is($flight->departure_airport_id, 1, 'got departure airport id');
    is($flight->destination_airport_id, 2, 'got destination airport id');
    is($flight->airline_id, 1, 'got airline');
    is($flight->code, 331, 'got code');
}
