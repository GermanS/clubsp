use Test::More tests => 2;

use strict;
use warnings;

use_ok('ClubSpain::XML::Partner::Terramar::Request::Hotel');

my $request_content =<<'';
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<integracion accion="prestatarios">
  <id_tipo_articulo_clase>1</id_tipo_articulo_clase>
  <provincia/>
  <id_zona>1322</id_zona>
  <info_extendida>0</info_extendida>
  <poblacion>LLORET DE MAR</poblacion>
  <id_idioma>3</id_idioma>
</integracion>


my $content = ClubSpain::XML::Partner::Terramar::Request::Hotel->request( 
  id_zona => 1322,
  info_extendida => 0,
  poblacion => 'LLORET DE MAR',
  id_idioma => 3
);
is($content, $request_content, 'check content');
