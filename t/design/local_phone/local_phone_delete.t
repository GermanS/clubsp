use Test::More tests => 6;

use strict;
use warnings;

use_ok('ClubSpain::Model::LocalPhone');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();
my $schema = $helper->schema();
my $count = $schema->resultset('LocalPhone')->search({})->count;

my $params = {
    office_id => 1,
    number    => 7778889991,
    is_published => 0,
};
my $phone = ClubSpain::Model::LocalPhone->new( $params );

my $object = $phone->create();

isa_ok($object, 'ClubSpain::Schema::Result::LocalPhone');
is $object->office_id, $params->{'office_id'}
    => 'got office id';
is $object->number, $params->{'number'}
    => 'got phone number';
is $object->is_published, 0
    => 'got is published';


ClubSpain::Model::LocalPhone->delete($object->id);

my $rs = $schema->resultset('LocalPhone')->search({});
is($rs->count, $count, 'no objects left');
