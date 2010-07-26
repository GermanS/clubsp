use Test::More tests => 2;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::Request::City');

my $expected = &request();
my $content = ClubSpain::XML::Olympia::Request::City->request(
    user      => 7777,
    password  => 8888,
    pais      => '00034',
    provincia => '029',
);
is($content, $expected, 'check content');

sub request {
    return <<"";
<?xml version="1.0" encoding="utf-8"?>
<DevuelvePoblaciones xmlns="http://tempuri.org/">
  <User>7777</User>
  <password>8888</password>
  <Pais>00034</Pais>
  <Provincia>029</Provincia>
</DevuelvePoblaciones>

}
