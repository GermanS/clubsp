use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Response::Occupation');

my $response =<<'';
<?xml version="1.0"?>
<integracion accion="datos_ocupaciones">
  <adultos_max>25</adultos_max>
  <adultos_min>0</adultos_min>
  <ninos_max>7</ninos_max>
  <pax_max>25</pax_max>
  <edad_nino_max>17</edad_nino_max>
</integracion>


my $array = ClubSpain::XML::Terramar::Response::Occupation->parse($response);
is(scalar @$array, 1, 'count objects');

my $occupation = ClubSpain::XML::Terramar::Occupation->new({
    adultos_max   => 25,
    adultos_min   => 0,
    ninos_max     => 7,
    pax_max       => 25,
    edad_nino_max => 17
});

is_deeply($array, [$occupation], 'returned occupation');
