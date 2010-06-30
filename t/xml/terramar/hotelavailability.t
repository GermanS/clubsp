use Test::More tests =>2;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Request::HotelAvailability');

my $request_content = <<'';
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<integracion accion="rangosdisponibilidad">
  <id_articulo>101</id_articulo>
</integracion>


my $content = ClubSpain::XML::Terramar::Request::HotelAvailability->request(
    id_articulo => 101
);
is($content, $request_content, 'check content');

