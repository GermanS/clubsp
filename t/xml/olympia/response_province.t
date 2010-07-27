use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::Province');
use_ok('ClubSpain::XML::Olympia::Response::Province');

my @expect = map new ClubSpain::XML::Olympia::Province($_),
    { Pais_Codigo => "00034", Provincia_Codigo => "003", Provincia_Nombre => "ALICANTE" },
    { Pais_Codigo => "00034", Provincia_Codigo => "004", Provincia_Nombre => "ALMERIA" },
    { Pais_Codigo => "00034", Provincia_Codigo => "007", Provincia_Nombre => "BALEARES" },
    { Pais_Codigo => "00034", Provincia_Codigo => "011", Provincia_Nombre => "CADIZ" },
    { Pais_Codigo => "00034", Provincia_Codigo => "018", Provincia_Nombre => "GRANADA" },
    { Pais_Codigo => "00034", Provincia_Codigo => "021", Provincia_Nombre => "HUELVA" },
    { Pais_Codigo => "00034", Provincia_Codigo => "029", Provincia_Nombre => "MALAGA" },
    { Pais_Codigo => "00034", Provincia_Codigo => "036", Provincia_Nombre => "PONTEVEDRA" },
    { Pais_Codigo => "00034", Provincia_Codigo => "038", Provincia_Nombre => "TENERIFE" },
    { Pais_Codigo => "00034", Provincia_Codigo => "046", Provincia_Nombre => "VALENCIA" };

my $response = &response();
my $result = ClubSpain::XML::Olympia::Response::Province->parse($response);

is_deeply($result, \@expect, 'check parse()');

sub response {
    return <<"";
<?xml version="1.0" encoding="ISO-8859-1"?>
<string xmlns="http://tempuri.org/">
  <Respuesta>
    <Provincias>
      <Provincia>
        <Pais_Codigo>00034</Pais_Codigo>
        <Provincia_Codigo>003</Provincia_Codigo>
        <Provincia_Nombre>ALICANTE</Provincia_Nombre>
      </Provincia>
      <Provincia>
        <Pais_Codigo>00034</Pais_Codigo>
        <Provincia_Codigo>004</Provincia_Codigo>
        <Provincia_Nombre>ALMERIA</Provincia_Nombre>
      </Provincia>
      <Provincia>
        <Pais_Codigo>00034</Pais_Codigo>
        <Provincia_Codigo>007</Provincia_Codigo>
        <Provincia_Nombre>BALEARES</Provincia_Nombre>
      </Provincia>
      <Provincia>
        <Pais_Codigo>00034</Pais_Codigo>
        <Provincia_Codigo>011</Provincia_Codigo>
        <Provincia_Nombre>CADIZ</Provincia_Nombre>
      </Provincia>
      <Provincia>
        <Pais_Codigo>00034</Pais_Codigo>
        <Provincia_Codigo>018</Provincia_Codigo>
        <Provincia_Nombre>GRANADA</Provincia_Nombre>
      </Provincia>
      <Provincia>
        <Pais_Codigo>00034</Pais_Codigo>
        <Provincia_Codigo>021</Provincia_Codigo>
        <Provincia_Nombre>HUELVA</Provincia_Nombre>
      </Provincia>
      <Provincia>
        <Pais_Codigo>00034</Pais_Codigo>
        <Provincia_Codigo>029</Provincia_Codigo>
        <Provincia_Nombre>MALAGA</Provincia_Nombre>
      </Provincia>
      <Provincia>
        <Pais_Codigo>00034</Pais_Codigo>
        <Provincia_Codigo>036</Provincia_Codigo>
        <Provincia_Nombre>PONTEVEDRA</Provincia_Nombre>
      </Provincia>
      <Provincia>
        <Pais_Codigo>00034</Pais_Codigo>
        <Provincia_Codigo>038</Provincia_Codigo>
        <Provincia_Nombre>TENERIFE</Provincia_Nombre>
      </Provincia>
      <Provincia>
        <Pais_Codigo>00034</Pais_Codigo>
        <Provincia_Codigo>046</Provincia_Codigo>
        <Provincia_Nombre>VALENCIA</Provincia_Nombre>
      </Provincia>
    </Provincias>
  </Respuesta>
</string>


}
