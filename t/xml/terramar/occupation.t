use Test::More tests => 7;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Occupation');

my $occupation = ClubSpain::XML::Terramar::Occupation->new({
    adultos_max   => 'adultos_max',
    adultos_min   => 'adultos_min',
    ninos_max     => 'ninos_max',
    pax_max       => 'pax_max',
    edad_nino_max => 'edad_nino_max',
});

isa_ok($occupation, 'ClubSpain::XML::Terramar::Occupation');
is($occupation->adultos_max, 'adultos_max', 'got adultos_max');
is($occupation->adultos_min, 'adultos_min', 'got adultos min');
is($occupation->ninos_max, 'ninos_max', 'got ninos_max');
is($occupation->pax_max, 'pax_max', 'got pax_max');
is($occupation->edad_nino_max, 'edad_nino_max', 'got edad_nino_max');
