use Test::More tests => 11;

use strict;
use warnings;

use_ok('ClubSpain::Design::Manufacturer');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();

#pass id to the function
{
    my $manufacturer = ClubSpain::Design::Manufacturer->fetch_by_id(2);
    isa_ok($manufacturer, 'ClubSpain::Schema::Manufacturer');
    is($manufacturer->code, 'AIRBUS', 'got  code');
    is($manufacturer->name, 'Airbus SAS', 'got name');
}


#retrive
{
    my $manufacturer = ClubSpain::Design::Manufacturer->new(
        id          => 2,
        code        => 'code',
        name        => 'name',
    );

    my $object = $manufacturer->fetch_by_id();
    isa_ok($object, 'ClubSpain::Schema::Manufacturer');
    is($object->code, 'AIRBUS', 'got  code');
    is($object->name, 'Airbus SAS', 'got name');
}

#exception
{
    eval {
        ClubSpain::Design::Manufacturer->fetch_by_id(1000);
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find Manufacturer: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}

#exception
{
    my $manufacturer = ClubSpain::Design::Manufacturer->new(
        id          => 1000,
        code        => 'xxxx',
        name        => 'name',
    );

    eval {
        $manufacturer->fetch_by_id();
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find Manufacturer: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}
