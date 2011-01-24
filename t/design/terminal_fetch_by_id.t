use Test::More tests => 13;

use strict;
use warnings;

use_ok('ClubSpain::Design::Terminal');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();

#pass id to the function
{
    my $terminal = ClubSpain::Design::Terminal->fetch_by_id(1);
    isa_ok($terminal, 'ClubSpain::Schema::Terminal');
    is($terminal->airport_id, 3, 'got airport');
    is($terminal->name, 'Terminal B', 'got name');
    is($terminal->is_published, 1, 'got is published');
}


#retrive
{
    my $terminal = ClubSpain::Design::Terminal->new(
        id          => 1,
        airport_id  => 0,
        name        => 'name',
        is_published=> 0,
    );

    my $object = $terminal->fetch_by_id();
    isa_ok($object, 'ClubSpain::Schema::Terminal');
    is($object->airport_id, 3, 'got airport');
    is($object->name, 'Terminal B', 'got name');
    is($object->is_published, 1, 'got is published');
}

#exception
{
    eval {
        ClubSpain::Design::Terminal->fetch_by_id(1000);
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find Terminal: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}

#exception
{
    my $terminal = ClubSpain::Design::Terminal->new(
        id          => 1000,
        airport_id  => 0,
        name        => 'name',
        is_published=> 1,
    );

    eval {
        $terminal->fetch_by_id();
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find Terminal: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}
