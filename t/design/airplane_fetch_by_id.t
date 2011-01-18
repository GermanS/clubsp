use Test::More tests => 16;

use strict;
use warnings;

use_ok('ClubSpain::Design::Airplane');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();

#pass id to the function
{
    my $airplane = ClubSpain::Design::Airplane->fetch_by_id(1);
    isa_ok($airplane, 'ClubSpain::Schema::Airplane');
    is($airplane->manufacturer_id, 2, 'got manufacturer code');
    is($airplane->iata, '318', 'got iata code');
    is($airplane->icao, 'A318', 'got icao code');
    is($airplane->name, 'A318', 'got name');
    is($airplane->is_published, 1, 'got is published');
}


#retrive
{
    my $airplane = ClubSpain::Design::Airplane->new(
        id          => 1,
        manufacturer_id => 1,
        iata        => 'xxx',
        icao        => 'xxxx',
        name        => 'name',
        is_published=> 0,
    );

    my $object = $airplane->fetch_by_id();
    is($object->manufacturer_id, 2, 'got manufacturer code');
    is($object->iata, '318', 'got iata code');
    is($object->icao, 'A318', 'got icao code');
    is($object->name, 'A318', 'got name');
    is($object->is_published, 1, 'got is published');
}

#exception
{
    eval {
        ClubSpain::Design::Airplane->fetch_by_id(1000);
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find Airplane: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}#   at t/design/airplane_fetch_by_id.t line 37.
#          got: '1'
#     expected: '2'


#exception
{
    my $airplane = ClubSpain::Design::Airplane->new(
        id          => 1000,
        manufacturer_id => 1,
        iata        => 'xxx',
        icao        => 'xxxx',
        name        => 'name',
        is_published=> 1,
    );

    eval {
        $airplane->fetch_by_id();
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find Airplane: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}
