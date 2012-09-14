use Test::More tests => 13;

use strict;
use warnings;

use_ok('ClubSpain::Model::LocalPhone');

use lib qw(t/lib);
use ClubSpain::Test;

my $helper = ClubSpain::Test->new();
my $params = {
    office_id    => 1,
    number       => 2233445566,
    is_published => 1,
};
my $phone = ClubSpain::Model::LocalPhone->new( $params );
my $init_object = $phone->create();

#pass id to the function
{
    my $object = ClubSpain::Model::LocalPhone->fetch_by_id($init_object->id);
    isa_ok($object, 'ClubSpain::Schema::Result::LocalPhone');
    is $object->office_id, $params->{'office_id'}
        => 'got office id';
    is $object->number, $params->{'number'}
        => 'got phone number';
    is $object->is_published, $params->{'is_published'}
        => 'got is published flag';
}


#retrive
{
    $phone->set_id($init_object->id);
    my $object = $phone->fetch_by_id();

    isa_ok($object, 'ClubSpain::Schema::Result::LocalPhone');
    is $object->office_id, $params->{'office_id'}
        => 'got office id';
    is $object->number, $params->{'number'}
        => 'got phone number';
    is $object->is_published, $params->{'is_published'}
        => 'got is published flag';
}

#exception
{
    eval {
        ClubSpain::Model::LocalPhone->fetch_by_id(1000);
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find LocalPhone: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}

#exception
{
    $phone->set_id(1000);

    eval {
        $phone->fetch_by_id();
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find LocalPhone: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}
