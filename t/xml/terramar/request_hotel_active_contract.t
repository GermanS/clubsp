use Test::More tests => 2;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Request::HotelActiveContract');

my $request_content = <<'';
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<integracion accion="articulosactivos">
  <id_prestatario>1</id_prestatario>
  <id_idioma>0</id_idioma>
  <id_tipo_articulo_clase>1</id_tipo_articulo_clase>
</integracion>


my $content = ClubSpain::XML::Terramar::Request::HotelActiveContract->request( 
    id_prestatario          => 1,
    id_idioma               => 0,
    id_tipo_articulo_clase  => 1,
);
is($content, $request_content, 'check content')
