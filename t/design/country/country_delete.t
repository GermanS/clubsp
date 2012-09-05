use Test::More tests => 8;

use strict;
use warnings;

use_ok('ClubSpain::Model::Country');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new( no_populate => 1 );

my $country = ClubSpain::Model::Country->new(
    name    => 'Soviet Union',
    alpha2  => 'su',
    alpha3  => 'suu',
    numerics => 111,
    is_published => 1,
);
my $object = $country->create();
isa_ok($object, 'ClubSpain::Schema::Result::Country');
is $object->name, 'Soviet Union'
    => 'got name';
is $object->alpha2, 'su'
    => 'got alpha2';
is $object->alpha3, 'suu'
    => 'got aplha3';
is $object->numerics, 111
    => 'got numerics';
is $object->is_published, 1
    => 'got is_published';


ClubSpain::Model::Country->delete($object->id);


my $rs = $helper->schema->resultset('Country')->search({});
is($rs->count, 0, 'no objects left');
