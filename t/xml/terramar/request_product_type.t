use Test::More tests =>2;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Request::ProductType');

my $request_content = <<'';
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<integracion accion="clases">
  <id_idioma>10</id_idioma>
  <id_tipo_articulo_superclase>11</id_tipo_articulo_superclase>
</integracion>



my $content = ClubSpain::XML::Terramar::Request::ProductType->request(
  id_idioma => 10,
  id_tipo_articulo_superclase => 11
);
is($content, $request_content, 'check content');
