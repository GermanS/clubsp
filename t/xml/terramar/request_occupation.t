use Test::More tests =>2;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Request::Occupation');

my $request_content = <<'';
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<integracion accion="ocupaciones">
  <id_tipo_articulo_clase>99</id_tipo_articulo_clase>
</integracion>

my $content = ClubSpain::XML::Terramar::Request::Occupation->request( 
    id_tipo_articulo_clase => 99,
);
is($content, $request_content, 'check content');
