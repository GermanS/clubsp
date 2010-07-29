use Test::More tests => 2;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::Request::RoomTypePB');

my $expected = &request();
my $content = ClubSpain::XML::Olympia::Request::RoomTypePB->request(
    user      => 7777,
    password  => 8888,
    idioma    => '02'
);
is($content, $expected, 'check content');

sub request {
    return <<"";
<?xml version="1.0" encoding="utf-8"?>
<DevuelveRegimenesPB xmlns="http://tempuri.org/">
  <User>7777</User>
  <password>8888</password>
  <Opciones>
    <Idioma>02</Idioma>
  </Opciones>
</DevuelveRegimenesPB>


}
