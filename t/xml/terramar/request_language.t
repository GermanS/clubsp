use Test::More tests => 2;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Request::Language');

my $request_content =<<'';
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<integracion accion="idiomas"/>


my $content = ClubSpain::XML::Terramar::Request::Language->request();
is($content, $request_content, 'check content');
