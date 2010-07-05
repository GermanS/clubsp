use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Response::Province');

my $response =<<'';
<?xml version="1.0"?>
<integracion accion="listado_provincias">
  <provincia>Alicante</provincia>
</integracion>

my $array = ClubSpain::XML::Terramar::Response::Province->parse($response);
is(scalar @$array, 1, 'count objects');

my $object = ClubSpain::XML::Terramar::Province->new({
    provincia => 'Alicante',
});

is_deeply($array, [$object], 'returned alicante province');
