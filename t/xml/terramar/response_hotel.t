use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Response::Hotel');

my $response =<<'';
<?xml version="1.0"?>
<integracion accion="listado_prestatarios">
  <prestatario>
    <id_prestatario>14</id_prestatario>
    <nombre_comercial>Apartamentos Monterey</nombre_comercial>
  </prestatario>
  <prestatario>
    <id_prestatario>53</id_prestatario>
    <nombre_comercial>confortel fuengirola</nombre_comercial>
  </prestatario>
</integracion>

my $array = ClubSpain::XML::Terramar::Response::Hotel->parse($response);
is(scalar @$array, 2, 'count objects');

my $hotel1 = ClubSpain::XML::Terramar::Hotel->new({
    id_prestatario => 14,
    nombre_comercial => 'Apartamentos Monterey',
});
my $hotel2 = ClubSpain::XML::Terramar::Hotel->new({
    id_prestatario => 53,
    nombre_comercial => 'confortel fuengirola',
});

is_deeply($array, [$hotel1, $hotel2], 'returned 2 hotels');
