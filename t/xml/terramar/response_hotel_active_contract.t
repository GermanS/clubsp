use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Response::HotelActiveContract');

my $response =<<'';
<?xml version="1.0"?>
<integracion accion="listado_articulos_activos">
  <articulo>
    <id>2911</id>
    <nombre>14 noches</nombre>
    <id_tipo_articulo_clase>67</id_tipo_articulo_clase>
    <id_tipo_articulo_superclase>17</id_tipo_articulo_superclase>
    <id_zona_pais>1</id_zona_pais>
    <id_zona>2</id_zona>
  </articulo>
</integracion>


my $array = ClubSpain::XML::Terramar::Response::HotelActiveContract->parse($response);
is(scalar @$array, 1, 'count objects');

my $contract = ClubSpain::XML::Terramar::HotelActiveContract->new({
    id                          => 2911,
    nombre                      => '14 noches',
    id_tipo_articulo_clase      => 67,
    id_tipo_articulo_superclase => 17,
    id_zona_pais                => 1,
    id_zona                     => 2,
});

is_deeply($array, [$contract], 'returned contract');
