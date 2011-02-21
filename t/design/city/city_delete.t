use Test::More tests => 6;

use strict;
use warnings;

use_ok('ClubSpain::Model::City');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema( );
my $count = $schema->resultset('City')->search({})->count;

my $city = ClubSpain::Model::City->new(
    country_id   => 1,
    name         => 'New Vasuki',
    is_published => 1,
);
my $object = $city->create();
isa_ok($object, 'ClubSpain::Schema::Result::City');
is($object->country_id, 1, 'got country id');
is($object->name, 'New Vasuki', 'got name');
is($object->is_published, 1, 'got is_published');


ClubSpain::Model::City->delete($object->id);


my $rs = $schema->resultset('City')->search({});
is($rs->count, $count, 'recently added cobject was removed');
