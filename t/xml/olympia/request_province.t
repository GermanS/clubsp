use Test::More tests => 2;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::Request::Province');

my $expected = &request();
my $content = ClubSpain::XML::Olympia::Request::Province->request(
    user => 7777,
    password => 8888,
    pais   => '00034'
);
is($content, $expected, 'check content');

sub request {
    return <<"";
<?xml version="1.0" encoding="utf-8"?>
<DevuelveProvincias xmlns="http://tempuri.org/">
  <User>7777</User>
  <password>8888</password>
  <Pais>00034</Pais>
</DevuelveProvincias>

}