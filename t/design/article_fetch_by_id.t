use Test::More tests => 17;

use strict;
use warnings;

use_ok('ClubSpain::Design::Article');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();

#pass id to the function
{
    my $story = ClubSpain::Design::Article->fetch_by_id(1);
    isa_ok($story, 'ClubSpain::Schema::Article');
    is($story->parent_id, 0, 'got parent_id');
    is($story->weight, 1, 'got weight');
    is($story->is_published, 0, 'got is published');
    is($story->header, 'HEADER1', 'got header');
    is($story->body, 'BODY1', 'got body');
}


#retrive
{
    my $story = ClubSpain::Design::Article->new(
        id => 1,
        parent_id => undef,
        weight => undef,
        is_published => undef,
        header => undef,
        body => undef,
    );

    my $object = $story->fetch_by_id();
    isa_ok($object, 'ClubSpain::Schema::Article');
    is($object->parent_id, 0, 'got parent_id');
    is($object->weight, 1, 'got weight');
    is($object->is_published, 0, 'got is published');
    is($object->header, 'HEADER1', 'got header');
    is($object->body, 'BODY1', 'got body');
}

#exception
{
    eval {
        ClubSpain::Design::Article->fetch_by_id(1000);
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find Article: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}

#exception
{
    my $story = ClubSpain::Design::Article->new(
        id => 1000,
        parent_id => undef,
        weight => undef,
        is_published => undef,
        header => undef,
        body => undef,
    );

    eval {
        $story->fetch_by_id();
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find Article: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}





