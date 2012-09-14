use Test::More tests => 17;

use strict;
use warnings;

use_ok('ClubSpain::Model::Office');

use lib qw(t/lib);
use ClubSpain::Test;

my $helper = ClubSpain::Test->new();
my $params = {
    company_id  => 1,
    zipcode     => 123456,
    street      => 'Address 20',
    name        => 'Office 1',
    is_published => 1,
};
my $office = ClubSpain::Model::Office->new( $params );
my $init_object  = $office->create();

#pass id to the function
{
    my $object = ClubSpain::Model::Office->fetch_by_id($init_object->id);
    isa_ok($object, 'ClubSpain::Schema::Result::Office');
    is $object->company_id, $params->{'company_id'}
        => 'got company id';
    is $object->zipcode, $params->{'zipcode'}
        => 'got zipcode';
    is $object->name, $params->{'name'}
        => 'got name';
    is $object->street, $params->{'street'}
        => 'got street';
    is $object->is_published, $params->{'is_published'}
        => 'got is published flag';
}


#retrive
{
    $office->set_id($init_object->id);
    my $object = $office->fetch_by_id();

    isa_ok($object, 'ClubSpain::Schema::Result::Office');
    is $object->company_id, $params->{'company_id'}
        => 'got company id';
    is $object->zipcode, $params->{'zipcode'}
        => 'got zipcode';
    is $object->name, $params->{'name'}
        => 'got name';
    is $object->street, $params->{'street'}
        => 'got street';
    is $object->is_published, $params->{'is_published'}
        => 'got is published flag';
}

#exception
{
    eval {
        ClubSpain::Model::Office->fetch_by_id(1000);
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find Office: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}

#exception
{
    $office->set_id(1000);

    eval {
        $office->fetch_by_id();
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find Office: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}
