use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Response::ProductClassification');

my $response =<<'';
<?xml version="1.0"?>
<integracion accion="listado_superclases">
  <superclase>
     <id_tipo_articulo_superclase>1</id_tipo_articulo_superclase>
     <nombre>Estancias</nombre>
     <orden>2</orden>
  </superclase>
  <superclase>
    <id_tipo_articulo_superclase>2</id_tipo_articulo_superclase>
    <nombre>Nieve</nombre>
    <orden>9</orden>
  </superclase>
  <superclase_predeterminada>1</superclase_predeterminada>
</integracion>


my $array = ClubSpain::XML::Terramar::Response::ProductClassification->parse($response);
is(scalar @$array, 2, 'count objects');

my $class1 = ClubSpain::XML::Terramar::ProductClassification->new({
    id_tipo_articulo_superclase => 1,
    nombre => 'Estancias',
    orden => 2
});
my $class2 = ClubSpain::XML::Terramar::ProductClassification->new({
    id_tipo_articulo_superclase => 2,
    nombre => 'Nieve',
    orden => 9,
});

is_deeply($array, [$class1, $class2], 'returned 2 classes');
