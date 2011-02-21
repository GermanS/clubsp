use Test::More tests => 4;

use strict;
use warnings;

use_ok('ClubSpain::Model::Fare');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();
my $count = $schema->resultset('Fare')->search({})->count;

my $fare = ClubSpain::Model::Fare->new(
    fare => 102
);

my $object = $fare->create();

isa_ok($object, 'ClubSpain::Schema::Result::Fare');
is($object->fare, 102, 'got fare');


ClubSpain::Model::Fare->delete($object->id);

my $rs = $schema->resultset('Fare')->search({});
is($rs->count, $count, 'no objects left');
