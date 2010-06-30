use Test::More tests => 2;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Request::HotelInfo');

my $request_content = <<'';
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<integracion accion="fichatecnicaprestatario">
  <id_prestatario>100</id_prestatario>
  <id_idioma>0</id_idioma>
</integracion>

my $content = ClubSpain::XML::Terramar::Request::HotelInfo->request(
    id_prestatario => 100,
    id_idioma => 0
);
is($content, $request_content, 'check content');
