use Test::More tests => 13;

use strict;
use warnings;

use_ok('ClubSpain::Model::Flight');

{
    my $flight = ClubSpain::Model::Flight->new(
        is_published            => 1,
        airport_of_departure    => 1,
        airport_of_arrival      => 2,
        airline_id              => 1,
        code                    => 331,
    );

    isa_ok($flight, 'ClubSpain::Model::Flight');
    is $flight->get_is_published, 1
        => 'got is published flag';
    is $flight->get_airport_of_departure, 1
        => 'got departure airport id';
    is $flight->get_airport_of_arrival, 2
        => 'got destination airport id';
    is $flight->get_airline_id, 1
        => 'got airline';
    is $flight->get_code, 331
        => 'got code';
}

{
    my $flight = ClubSpain::Model::Flight->new(
        is_published            => 1,
        airport_of_departure    => 1,
        airport_of_arrival      => 2,
        airline_id              => 1,
        code                    => 331,
    );

    isa_ok($flight, 'ClubSpain::Model::Flight');
    is $flight->get_is_published, 1
        => 'got is published flag';
    is $flight->get_airport_of_departure, 1
        => 'got departure airport id';
    is $flight->get_airport_of_arrival, 2
        => 'got destination airport id';
    is $flight->get_airline_id, 1
        => 'got airline';
    is $flight->get_code, 331
        => 'got code';
}
