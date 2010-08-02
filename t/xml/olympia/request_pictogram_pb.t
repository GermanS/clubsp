use Test::More tests => 2;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::Request::PictogramPB');

my $expected = &request();
my $content = ClubSpain::XML::Olympia::Request::PictogramPB->request(
    user      => 7777,
    password  => 8888,
    idioma    => '01',
);
is($content, $expected, 'check content');

sub request {
    return <<"";
<?xml version="1.0" encoding="utf-8"?>
<DevuelveSimbolosPB xmlns="http://tempuri.org/">
  <User>7777</User>
  <password>8888</password>
  <Opciones>
    <Idioma>01</Idioma>
  </Opciones>
</DevuelveSimbolosPB>


}
