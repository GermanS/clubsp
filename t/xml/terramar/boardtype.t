use Test::More tests => 2;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Request::BoardType');

my $request_content = <<'';
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<integracion accion="suplementosregimen">
  <id_idioma>0</id_idioma>
</integracion>

my $content = ClubSpain::XML::Terramar::Request::BoardType->request(
    id_idioma => 0
);
is($content, $request_content, 'check content');
