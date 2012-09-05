use Test::More tests => 15;

use strict;
use warnings;

use_ok('ClubSpain::Model::Airline');

use lib qw(t/lib);
use ClubSpain::Test;

my $helper = ClubSpain::Test->new();

#pass id to the function
{
    my $airline = ClubSpain::Model::Airline->fetch_by_id(1);
    isa_ok($airline, 'ClubSpain::Schema::Result::Airline');
    is $airline->iata, 'NN'
        => 'got iata code';
    is $airline->icao, 'MOV'
        => 'got icao code';
    is $airline->name, 'VIM Airlines'
        => 'got name';
    is $airline->is_published, 1
        => 'got is published';
}


#retrive
{
    my $airline = ClubSpain::Model::Airline->new(
        id   => 1,
        iata => 'xx',
        icao => 'xxx',
        name => 'name',
        is_published => 0,
    );

    my $object = $airline->fetch_by_id();
    isa_ok($object, 'ClubSpain::Schema::Result::Airline');
    is $object->iata, 'NN'
        => 'got iata';
    is $object->icao, 'MOV'
        => 'got icao';
    is $object->name, 'VIM Airlines'
        => 'got name';
    is $object->is_published, 1
        => 'got is published';
}

#exception
{
    eval {
        ClubSpain::Model::Airline->fetch_by_id(1000);
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find Airline: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}

#exception
{
    my $airline = ClubSpain::Model::Airline->new(
        id   => 1000,
        iata => 'xx',
        icao => 'xxx',
        name => 'name',
        is_published=> 1,
    );

    eval {
        $airline->fetch_by_id();
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find Airline: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}
