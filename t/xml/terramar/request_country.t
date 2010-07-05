use Test::More tests =>2;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Request::Country');

my $request_content = <<'';
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<integracion accion="paises">
  <id_tipo_articulo_clase>100</id_tipo_articulo_clase>
</integracion>


my $content = ClubSpain::XML::Terramar::Request::Country->request( id_tipo_articulo_clase => 100 );
is($content, $request_content, 'check content');
