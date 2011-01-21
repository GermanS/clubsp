use Test::More tests => 15;

use strict;
use warnings;

use_ok('ClubSpain::Design::Flight');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();

#pass id to the function
{
    my $flight = ClubSpain::Design::Flight->fetch_by_id(1);
    isa_ok($flight, 'ClubSpain::Schema::Flight');
    is($flight->departure_airport_id, 1, 'geo departure airport');
    is($flight->destination_airport_id, 4, 'got destination airport');
    is($flight->airline_id, 1, 'got airline');
    is($flight->code, 331, 'got code');
}


#retrive
{
    my $flight = ClubSpain::Design::Flight->new(
        id                      => 2,
        departure_airport_id    => 0,
        destination_airport_id  => 0,
        airline_id              => 0,
        code                    => 111,
    );

    my $object = $flight->fetch_by_id();
    isa_ok($object, 'ClubSpain::Schema::Flight');
    is($object->departure_airport_id,   4,   'got departure airport');
    is($object->destination_airport_id, 1,   'got destination airport');
    is($object->airline_id,             1,   'got airline');
    is($object->code,                   332, 'got code');
}

#exception
{
    eval {
        ClubSpain::Design::Flight->fetch_by_id(1000);
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find Flight: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}

#exception
{
    my $flight = ClubSpain::Design::Flight->new(
        id          => 1000,
        departure_airport_id    => 1,
        destination_airport_id  => 2,
        airline_id              => 1,
        code                    => 123,
    );

    eval {
        $flight->fetch_by_id();
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find Flight: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}
