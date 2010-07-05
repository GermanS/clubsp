use Test::More tests =>3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Response::ProductType');

my $response =<<'';
<?xml version="1.0"?>
<integracion accion="listado_clases">
  <clase>
    <id_tipo_articulo_clase>1</id_tipo_articulo_clase>
    <id_tipo_menu>1</id_tipo_menu>
    <articulo_clase>Hoteles</articulo_clase>
    <busqueda_predeterminada>Buscar Hotel</busqueda_predeterminada>
    <zona_predeterminada>Costa del Sol</zona_predeterminada>
    <regimen_predeterminado>Alojamiento y desayuno</regimen_predeterminado>
    <orden>4</orden>
    <visible_minorista>1</visible_minorista>
    <filtros_busqueda_diferencia_dias>1</filtros_busqueda_diferencia_dias>
  </clase>
  <clase>
    <id_tipo_articulo_clase>7</id_tipo_articulo_clase>
    <id_tipo_menu>6</id_tipo_menu>
    <articulo_clase>vacaciones</articulo_clase>
    <busqueda_predeterminada>Buscar Paquete cerrado</busqueda_predeterminada>
    <zona_predeterminada/>
    <regimen_predeterminado/>
    <orden>8</orden>
    <visible_minorista>1</visible_minorista>
    <filtros_busqueda_diferencia_dias>1</filtros_busqueda_diferencia_dias>
  </clase>
</integracion>

my $array = ClubSpain::XML::Terramar::Response::ProductType->parse($response);
is(scalar @$array, 2, 'count objects');

my $class1 = ClubSpain::XML::Terramar::ProductType->new({
    id_tipo_articulo_clase  => 1,
    id_tipo_menu            => 1,
    articulo_clase          => 'Hoteles',
    busqueda_predeterminada => 'Buscar Hotel',
    zona_predeterminada     => 'Costa del Sol',
    regimen_predeterminado  => 'Alojamiento y desayuno',
    orden                   => 4,
    visible_minorista       => 1,
    filtros_busqueda_diferencia_dias => 1,
});
my $class2 = ClubSpain::XML::Terramar::ProductType->new({
    id_tipo_articulo_clase  => 7,
    id_tipo_menu            => 6,
    articulo_clase          => 'vacaciones',
    busqueda_predeterminada => 'Buscar Paquete cerrado',
    zona_predeterminada     => '',
    regimen_predeterminado  => '',
    orden                   => 8,
    visible_minorista       => 1,
    filtros_busqueda_diferencia_dias => 1,
});

is_deeply($array, [$class1, $class2], 'returned 2 classes');
