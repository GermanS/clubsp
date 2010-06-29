use Test::More tests => 2;

use strict;
use warnings;

use_ok('ClubSpain::XML::Partner::Terramar::Request::Zona');

my $request_content =<<'';
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<integracion accion="zonas">
  <id_tipo_articulo_clase>1</id_tipo_articulo_clase>
  <id_zona_pais>1</id_zona_pais>
</integracion>


my $content = ClubSpain::XML::Partner::Terramar::Request::Zona->request( country_id => 1 );
is($content, $request_content, 'check content');
