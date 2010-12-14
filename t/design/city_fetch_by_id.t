use Test::More tests => 14;

use strict;
use warnings;

use_ok('ClubSpain::Design::City');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();

#pass id to the function
{
    my $city = ClubSpain::Design::City->fetch_by_id(1);
    isa_ok($city, 'ClubSpain::Schema::City');
    is($city->country_id, 1, 'got country id');
    is($city->name, 'Moscow', 'got name');
    is($city->is_published, 1, 'got is_published');
}

#retrive
{
    my $city = ClubSpain::Design::City->new(
        id => 1,
        country_id => 1,
        name => 'name',
        is_published => 1,
    );

    my $object = $city->fetch_by_id();
    isa_ok($object, 'ClubSpain::Schema::City');
    is($object->id, 1, 'got id');
    is($object->country_id, 1, 'got country id');
    is($object->name, 'Moscow', 'got name');
    is($object->is_published, 1, 'got is_published');
}

#exception
{
    eval {
        ClubSpain::Design::City->fetch_by_id(1000);
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
    my $city = ClubSpain::Design::City->new(
        id => 1000,
        country_id => 1,
        name => 'some name',
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
