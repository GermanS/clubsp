use Test::More tests => 2;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Request::Province');

my $request_content =<<'';
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<integracion accion="provincias">
  <id_tipo_articulo_clase>10</id_tipo_articulo_clase>
  <id_zona>11</id_zona>
</integracion>


my $content = ClubSpain::XML::Terramar::Request::Province->request(
    id_tipo_articulo_clase => 10,
    id_zona => 11
);
is($content, $request_content, 'check content');
