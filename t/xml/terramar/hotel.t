use Test::More tests => 4;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Hotel');

my $hotel = ClubSpain::XML::Terramar::Hotel->new({
    id_prestatario   => 100,
    nombre_comercial => 'CasaBlanca'
});

isa_ok($hotel, 'ClubSpain::XML::Terramar::Hotel');
is($hotel->id_prestatario, 100, 'got id');
is($hotel->nombre_comercial, 'CasaBlanca', 'got nombre')
