use Test::More tests => 18;

use strict;
use warnings;
use utf8;

use_ok('ClubSpain::Model::City');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();

#pass id to the function
{
    my $city = ClubSpain::Model::City->fetch_by_id(1);
    isa_ok($city, 'ClubSpain::Schema::Result::City');
    is($city->country_id, 1, 'got country id');
    is($city->iata, 'MOW', 'got iata');
    is($city->name, 'Moscow', 'got name');
    is($city->name_ru, 'Москва', 'got name ru');
    is($city->is_published, 1, 'got is_published');
}

#retrive
{
    my $city = ClubSpain::Model::City->new(
        id => 1,
        country_id => 1,
        iata => 'zzz',
        name => 'name',
        name_ru => 'xxx',
        is_published => 1,
    );

    my $object = $city->fetch_by_id();
    isa_ok($object, 'ClubSpain::Schema::Result::City');
    is($object->id, 1, 'got id');
    is($object->country_id, 1, 'got country id');
    is($object->iata, 'MOW', 'got iata code');
    is($object->name, 'Moscow', 'got name');
    is($object->name_ru, 'Москва', 'got name ru');
    is($object->is_published, 1, 'got is_published');
}

#exception
{
    eval {
        ClubSpain::Model::City->fetch_by_id(1000);
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find City: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}

#exception
{
    my $city = ClubSpain::Model::City->new(
        id => 1000,
        country_id => 1,
        iata => 'xxx',
        name => 'some name',
        name_ru => 'ddd',
        is_published => 1,
    );

    eval {
        $city->fetch_by_id();
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find City: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}
