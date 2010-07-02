use Test::More tests => 2;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Request::ProductClassification');

my $request_content = <<'';
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<integracion accion="superclases">
  <id_idioma>1</id_idioma>
</integracion>

my $content = ClubSpain::XML::Terramar::Request::ProductClassification->request(
    id_idioma => 1
);
is($content, $request_content, 'check content');
