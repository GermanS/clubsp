use Test::More tests => 9;

use strict;
use warnings;

use_ok('ClubSpain::Model::Fare');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();

#pass id to the function
{
    my $fare = ClubSpain::Model::Fare->fetch_by_id(1);
    isa_ok($fare, 'ClubSpain::Schema::Result::Fare');
    is($fare->fare, 100, 'got  fare');
}


#retrive
{
    my $fare = ClubSpain::Model::Fare->new(
        id    => 1,
        fare  => 10000
    );

    my $object = $fare->fetch_by_id();
    isa_ok($object, 'ClubSpain::Schema::Result::Fare');
    is($object->fare, 100, 'got fare');
}

#exception
{
    eval {
        ClubSpain::Model::Fare->fetch_by_id(1000);
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find Fare: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}

#exception
{
    my $fare = ClubSpain::Model::Fare->new(
        id          => 1000,
        fare        => 1234
    );

    eval {
        $fare->fetch_by_id();
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find Fare: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}
