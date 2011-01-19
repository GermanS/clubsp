use Test::More tests => 13;

use strict;
use warnings;

use_ok('ClubSpain::Design::FareClass');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();

#pass id to the function
{
    my $fareclass = ClubSpain::Design::FareClass->fetch_by_id(1);
    isa_ok($fareclass, 'ClubSpain::Schema::FareClass');
    is($fareclass->code, 'Y', 'got code');
    is($fareclass->name, 'Economy', 'got name');
    is($fareclass->is_published, 1, 'got is published');
}


#retrive
{
    my $fareclass = ClubSpain::Design::FareClass->new(
        id          => 1,
        code        => 'x',
        name        => 'name',
        is_published=> 0,
    );

    my $object = $fareclass->fetch_by_id();
    isa_ok($object, 'ClubSpain::Schema::FareClass');
    is($object->code, 'Y', 'got code');
    is($object->name, 'Economy', 'got name');
    is($object->is_published, 1, 'got is published');
}

#exception
{
    eval {
        ClubSpain::Design::FareClass->fetch_by_id(1000);
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find FareClass: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}

#exception
{
    my $fareclass = ClubSpain::Design::FareClass->new(
        id          => 1000,
        code        => 'x',
        name        => 'name',
        is_published=> 1,
    );

    eval {
        $fareclass->fetch_by_id();
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find FareClass: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}
