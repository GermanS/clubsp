use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::Image');
use_ok('ClubSpain::XML::Olympia::Response::Image');

my @expect = map new ClubSpain::XML::Olympia::Image($_),
{ Codigo => "CS000150", Orden => "0", Url => "http://89.140.26.66/Fotos/PlayaBonita/facha.jpg" },
{ Codigo => "CS000150", Orden => "1", Url => "http://89.140.26.66/Fotos/PlayaBonita/habt.jpg" },
{ Codigo => "CS000150", Orden => "2", Url => "http://89.140.26.66/Fotos/PlayaBonita/vario.jpg" };

my $response = &response();
my $result = ClubSpain::XML::Olympia::Response::Image->parse($response);

is_deeply($result, \@expect, 'check parse()');

sub response {
    return <<"";
<?xml version="1.0" encoding="ISO-8859-1"?>
<string xmlns="http://tempuri.org/">
  <Respuesta>
    <Imagenes>
      <Imagen>
        <Codigo>CS000150</Codigo>
        <Orden>0</Orden>
        <Url>http://89.140.26.66/Fotos/PlayaBonita/facha.jpg</Url>
      </Imagen>
      <Imagen>
        <Codigo>CS000150</Codigo>
        <Orden>1</Orden>
        <Url>http://89.140.26.66/Fotos/PlayaBonita/habt.jpg</Url>
      </Imagen>
      <Imagen>
        <Codigo>CS000150</Codigo>
        <Orden>2</Orden>
        <Url>http://89.140.26.66/Fotos/PlayaBonita/vario.jpg</Url>
      </Imagen>
    </Imagenes>
  </Respuesta>
</string>

}
