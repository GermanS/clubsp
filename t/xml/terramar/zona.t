use Test::More tests => 4;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Zona');

my $zona = ClubSpain::XML::Terramar::Zona->new({
    id_zona => 1,
    nombre => 'zona'
});

isa_ok($zona, 'ClubSpain::XML::Terramar::Zona');
is($zona->id_zona, 1, 'got zona id');
is($zona->nombre, 'zona', 'got nombre');
