use Test::More tests => 2;

use strict;
use warnings;

use_ok('ClubSpain::XML::Partner::Terramar::Request::City');

my $request_content = <<'';
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<integracion accion="poblaciones">
  <id_tipo_articulo_clase>1</id_tipo_articulo_clase>
  <id_zona>1</id_zona>
</integracion>


my $content = ClubSpain::XML::Partner::Terramar::Request::City->request(zona_id => 1);
is($content, $request_content, 'check content');
