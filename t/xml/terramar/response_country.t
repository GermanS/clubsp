use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Response::Country');

my $response =<<'';
<?xml version="1.0"?>
<integracion accion="listado_paises">
  <pais>
    <id_zona_pais>3</id_zona_pais>
    <nombre>Andorra</nombre>
  </pais>
  <pais>
    <id_zona_pais>2</id_zona_pais>
    <nombre>Portugal</nombre>
  </pais>
</integracion>

my $array = ClubSpain::XML::Terramar::Response::Country->parse($response);
is(scalar @$array, 2, 'count objects');

my $object1 = ClubSpain::XML::Terramar::Country->new({
    id_zona_pais => 3,
    nombre       => 'Andorra',
});
my $object2 = ClubSpain::XML::Terramar::Country->new({
    id_zona_pais => 2,
    nombre       => 'Portugal',
});

is_deeply($array, [$object1, $object2], 'returned 2 countries');
