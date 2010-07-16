use Test::More tests => 3;

use strict;
use warnings;

use utf8;

use_ok('ClubSpain::XML::Terramar::Response::BoardType');

my $response = <<'';
<integracion accion="listado_suplementos_regimen">
  <tipo_suplemento>
    <id_tipo_suplemento>1</id_tipo_suplemento>
    <nombre>Sólo alojamiento</nombre>
  </tipo_suplemento>
  <tipo_suplemento>
    <id_tipo_suplemento>2</id_tipo_suplemento>
    <nombre>Alojamiento y desayuno</nombre>
  </tipo_suplemento>
</integracion>

my $array = ClubSpain::XML::Terramar::Response::BoardType->parse($response);
is(scalar @$array, 2, 'count objects');

my $object1 = ClubSpain::XML::Terramar::BoardType->new({
    id_tipo_suplemento => 1,
    nombre => 'Sólo alojamiento'
});
my $object2 = ClubSpain::XML::Terramar::BoardType->new({
    id_tipo_suplemento => 2,
    nombre => 'Alojamiento y desayuno'
});

is_deeply($array, [$object1, $object2], 'returned 2 board types');


