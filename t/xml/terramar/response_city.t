use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Response::City');

my $response =<<'';
<?xml version="1.0"?>
<integracion accion="listado_poblaciones">
  <poblacion>Benidorm</poblacion>
  <poblacion>Calpe</poblacion>
</integracion>


my $array = ClubSpain::XML::Terramar::Response::City->parse($response);
is(scalar @$array, 2, 'count objects');

my $object1 = ClubSpain::XML::Terramar::City->new({
    poblacion => 'Benidorm',
});
my $object2 = ClubSpain::XML::Terramar::City->new({
    poblacion => 'Calpe',
});

is_deeply($array, [$object1, $object2], 'returned 2 cities');
