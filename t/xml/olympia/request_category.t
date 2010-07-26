use Test::More tests => 2;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::Request::Category');

my $request_content = <<'';
<?xml version="1.0" encoding="utf-8"?>
<DevuelveCategorias xmlns="http://tempuri.org/">
  <User>7777</User>
  <password>8888</password>
</DevuelveCategorias>


my $content = ClubSpain::XML::Olympia::Request::Category->request( user => 7777, password => 8888 );
is($content, $request_content, 'check content');
