use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Response::HotelAvailability');

my $response =<<'';
<?xml version="1.0"?>
<integracion accion="rangos_disponibilidad">
  <intervalo fecha_desde="2009-12-11" disponibilidad="0" fecha_hasta="2009-12-24"/>
  <intervalo fecha_desde="2009-12-25" disponibilidad="1" fecha_hasta="2010-01-19"/>
</integracion>


my $array = ClubSpain::XML::Terramar::Response::HotelAvailability->parse($response);
is(scalar @$array, 2, 'count objects');

my $object1 = ClubSpain::XML::Terramar::HotelAvailability->new({
    fecha_desde    => '2009-12-11',
    fecha_hasta    => '2009-12-24',
    disponibilidad => 0,
});
my $object2 = ClubSpain::XML::Terramar::HotelAvailability->new({
    fecha_desde    => '2009-12-25',
    fecha_hasta    => '2010-01-19',
    disponibilidad => 1,
});

is_deeply($array, [$object1, $object2], 'returned 2 availability ranges');
