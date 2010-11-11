use Test::More tests => 7;

use strict;
use warnings;

use_ok('ClubSpain::Design::Country');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema( no_populate => 1 );

my $country = ClubSpain::Design::Country->new(
    name => 'Soviet Union',
    alpha2 => 'su',
    alpha3 => 'suu',
    numerics => 111,
);
my $object = $country->create();
isa_ok($object, 'ClubSpain::Schema::Country');
is($object->name, 'Soviet Union', 'got name');
is($object->alpha2, 'su', 'got alpha2');
is($object->alpha3, 'suu', 'got aplha3');
is($object->numerics, 111, 'got numerics');


ClubSpain::Design::Country->delete($object->id);


my $rs = $schema->resultset('Country')->search({});
is($rs->count, 0, 'no objects left');


