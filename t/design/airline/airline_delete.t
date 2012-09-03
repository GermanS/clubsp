use Test::More tests => 7;

use strict;
use warnings;

use_ok('ClubSpain::Model::Airline');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();
my $schema = $helper->schema();
my $count = $schema->resultset('Airline')->search({})->count;

my $airline = ClubSpain::Model::Airline->new(
    iata     => 'xx',
    icao     => 'xxx',
    airline  => 'xx xxx',
    is_published => 0,
);

my $object = $airline->create();

isa_ok($object, 'ClubSpain::Schema::Result::Airline');
is($object->iata, 'xx', 'got iata code');
is($object->icao, 'xxx', 'got icao code');
is($object->name, 'xx xxx', 'got name');
is($object->is_published, 0, 'got is published');


ClubSpain::Model::Airline->delete($object->id);

my $rs = $schema->resultset('Airline')->search({});
is($rs->count, $count, 'no objects left');
