use Test::More tests =>5;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::ProductClassification');

my $product = ClubSpain::XML::Terramar::ProductClassification->new({
    id_tipo_articulo_superclase => 1,
    nombre => 'nombre',
    orden  => 'orden'
});


isa_ok($product, 'ClubSpain::XML::Terramar::ProductClassification');
is($product->id_tipo_articulo_superclase, 1, 'got id');
is($product->nombre, 'nombre', 'got nombre');
is($product->orden, 'orden', 'got orden');
