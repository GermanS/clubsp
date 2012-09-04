use Test::More tests => 8;

use strict;
use warnings;
use utf8;

use_ok('ClubSpain::Model::City');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();
my $schema = $helper->schema;
my $count = $schema->resultset('City')->search({})->count;

my $city = ClubSpain::Model::City->new(
    country_id   => 1,
    iata         => 'NYC',
    name_en      => 'New Vasuki',
    name_ru      => 'Васюки',
    is_published => 1,
);
my $object = $city->create();
isa_ok($object, 'ClubSpain::Schema::Result::City');
is($object->country_id, 1, 'got country id');
is($object->iata, 'NYC', 'got iata code');
is($object->name, 'New Vasuki', 'got name');
is($object->name_ru, 'Васюки', 'got name');
is($object->is_published, 1, 'got is_published');


ClubSpain::Model::City->delete($object->id);


my $rs = $schema->resultset('City')->search({});
is($rs->count, $count, 'recently added cobject was removed');
