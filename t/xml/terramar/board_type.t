use Test::More tests =>4;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::BoardType');

my $type = ClubSpain::XML::Terramar::BoardType->new({
    id_tipo_suplemento => 'suplemento',
    nombre => 'nombre'
});


isa_ok($type, 'ClubSpain::XML::Terramar::BoardType');
is($type-> id_tipo_suplemento, 'suplemento', 'got id tipo suplemento');
is($type->nombre, 'nombre', 'got nombre');
