use Test::More tests => 17;

use strict;
use warnings;

use_ok('ClubSpain::Model::Airport');

use lib qw(t/lib);
use ClubSpain::Test;

my $helper = ClubSpain::Test->new();

#pass id to the function
{
    my $port = ClubSpain::Model::Airport->fetch_by_id(1);
    isa_ok($port, 'ClubSpain::Schema::Result::Airport');
    is($port->city_id, 1, 'got city id');
    is($port->iata, 'DME', 'got iata code');
    is($port->icao, 'UUDD', 'got icao code');
    is($port->name, 'Domodedovo', 'got header');
    is($port->is_published, 1, 'got is published');
}


#retrive
{
    my $port = ClubSpain::Model::Airport->new(
        id          => 1,
        city_id     => 1,
        iata        => 'iat',
        icao        => 'icao',
        name        => 'name',
        is_published=> 0,
    );

    my $object = $port->fetch_by_id();
    isa_ok($object, 'ClubSpain::Schema::Result::Airport');
    is($object->city_id, 1, 'got city id');
    is($object->iata, 'DME', 'got iata');
    is($object->icao, 'UUDD', 'got icao');
    is($object->name, 'Domodedovo', 'got name');
    is($object->is_published, 1, 'got is published');
}

#exception
{
    eval {
        ClubSpain::Model::Airport->fetch_by_id(1000);
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find Airport: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}

#exception
{
    my $port = ClubSpain::Model::Airport->new(
        id          => 1000,
        city_id     => 1,
        iata        => 'xxx',
        icao        => 'xxxx',
        name        => 'name',
        is_published=> 1,
    );

    eval {
        $port->fetch_by_id();
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find Airport: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}





