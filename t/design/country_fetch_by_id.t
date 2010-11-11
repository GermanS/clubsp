use Test::More tests => 6;

use strict;
use warnings;

use_ok('ClubSpain::Design::Country');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();

my $country = ClubSpain::Design::Country->fetch_by_id(1);
isa_ok($country, 'ClubSpain::Schema::Country');
is($country->name, 'Russia', 'got name');
is($country->alpha2, 'ru', 'got alpha2');
is($country->alpha3, 'rus', 'got alpha3');
is($country->numerics, 7, 'got numerics');


