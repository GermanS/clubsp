use Test::More tests => 16;

use strict;
use warnings;

use_ok('ClubSpain::Design::Country');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();

#pass id to the function
{
    my $country = ClubSpain::Design::Country->fetch_by_id(1);
    isa_ok($country, 'ClubSpain::Schema::Country');
    is($country->name, 'Russia', 'got name');
    is($country->alpha2, 'ru', 'got alpha2');
    is($country->alpha3, 'rus', 'got alpha3');
    is($country->numerics, 7, 'got numerics');
}

#retrive
{
    my $country = ClubSpain::Design::Country->new(
        id => 1,
        name => 'RF',
        alpha2 => 'RR',
        alpha3 => 'RRS',
        numerics => 70,
    );

    my $object = $country->fetch_by_id();
    isa_ok($object, 'ClubSpain::Schema::Country');
    is($object->id, 1, 'got id');
    is($object->name, 'Russia', 'got name');
    is($object->alpha2, 'ru', 'got alpha2');
    is($object->alpha3, 'rus', 'got alpha3');
    is($object->numerics, 7, 'got numerics');
}

#exception
{
    eval {
        ClubSpain::Design::Country->fetch_by_id(1000);
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find Country: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}

#exception
{
    my $country = ClubSpain::Design::Country->new(
        id => 1000,
        name => 'russia',
        alpha2 => 'ru',
        alpha3 => 'rus',
        numerics => 7,
    );

    eval {
        $country->fetch_by_id();
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find Country: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}




