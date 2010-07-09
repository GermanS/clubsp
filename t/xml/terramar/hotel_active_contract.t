use Test::More tests => 8;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::HotelActiveContract');

my $active = ClubSpain::XML::Terramar::HotelActiveContract->new({
    id                          => 'id',
    nombre                      => 'nombre',
    id_tipo_articulo_clase      => 'id_tipo_articulo_clase',
    id_tipo_articulo_superclase => 'id_tipo_articulo_superclase',
    id_zona_pais                => 'id_zona_pais',
    id_zona                     => 'id_zona',
});
isa_ok($active, 'ClubSpain::XML::Terramar::HotelActiveContract');
is($active->id, 'id', 'got id');
is($active->nombre, 'nombre', 'got nombre');
is($active->id_tipo_articulo_clase, 'id_tipo_articulo_clase', 'got id_tipo_articulo_class');
is($active->id_tipo_articulo_superclase, 'id_tipo_articulo_superclase', 'got id_tipo_articulo_superclase');
is($active->id_zona_pais, 'id_zona_pais', 'got id_zona_pais');
is($active->id_zona, 'id_zona', 'got id_zona');
