use Test::More tests => 7;

use strict;
use warnings;

use_ok('ClubSpain::Model::Airline');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();
my $count = $schema->resultset('Airline')->search({})->count;

my $airline = ClubSpain::Model::Airline->new(
    iata    => 'xx',
    icao    => 'xxx',
    name    => 'xx xxx',
    is_published => 0,
);

my $object = $airline->create();

isa_ok($object, 'ClubSpain::Schema::Airline');
is($object->iata, 'xx', 'got iata code');
is($object->icao, 'xxx', 'got icao code');
is($object->name, 'xx xxx', 'got name');
is($object->is_published, 0, 'got is published');


ClubSpain::Model::Airline->delete($object->id);

my $rs = $schema->resultset('Airline')->search({});
is($rs->count, $count, 'no objects left');
