use Test::More tests => 3;

use strict;
use warnings;

use utf8;

use_ok('ClubSpain::XML::Terramar::Response::Language');

my $response =<<'';
<?xml version="1.0"?>
<integracion accion="listado_idiomas">
  <idioma>
    <id_idioma>0</id_idioma>
    <nombre_idioma>Español</nombre_idioma>
    <logo_idioma>http://www.orbisbooking.com/owbooking/idiomas/banderas/es_flag.gif</logo_idioma>
  </idioma>
  <idioma>
    <id_idioma>1</id_idioma>
    <nombre_idioma>Alemán</nombre_idioma>
    <logo_idioma>http://www.orbisbooking.com/owbooking/idiomas/banderas/de_flag.gif</logo_idioma>
  </idioma>
</integracion>

my $array = ClubSpain::XML::Terramar::Response::Language->parse($response);
is(scalar @$array, 2, 'count objects');

my $idioma1 = ClubSpain::XML::Terramar::Language->new({
    id_idioma => 0,
    nombre_idioma => 'Español',
    logo_idioma => 'http://www.orbisbooking.com/owbooking/idiomas/banderas/es_flag.gif'
});
my $idioma2 = ClubSpain::XML::Terramar::Language->new({
    id_idioma => 1,
    nombre_idioma => 'Alemán',
    logo_idioma => 'http://www.orbisbooking.com/owbooking/idiomas/banderas/de_flag.gif'
});

is_deeply($array, [$idioma1, $idioma2], 'returned 2 idiomas');

