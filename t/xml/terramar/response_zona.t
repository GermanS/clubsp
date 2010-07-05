use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Response::Zona');

my $response =<<'';
<?xml version="1.0"?>
<integracion accion="listado_zonas">
  <zona>
    <id_zona>11</id_zona>
    <nombre>Canarias</nombre>
  </zona>
  <zona>
    <id_zona>1</id_zona>
    <nombre>Costa Blanca</nombre>
  </zona>
</integracion>


my $array = ClubSpain::XML::Terramar::Response::Zona->parse($response);
is(scalar @$array, 2, 'count objects');

my $object1 = ClubSpain::XML::Terramar::Zona->new({
    id_zona  => 11,
    nombre   => 'Canarias',
});
my $object2 = ClubSpain::XML::Terramar::Zona->new({
    id_zona  => 1,
    nombre   => 'Costa Blanca',
});

is_deeply($array, [$object1, $object2], 'returned 2 zones');
