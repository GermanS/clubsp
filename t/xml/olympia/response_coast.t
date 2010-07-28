use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::Coast');
use_ok('ClubSpain::XML::Olympia::Response::Coast');

my @expect = map new ClubSpain::XML::Olympia::Coast($_),
    { Codigo => "01", Descripcion => "Costa del Sol (Malaga)" },
    { Codigo => "02", Descripcion => "Costa de la Luz (Cadiz - Huelva)" },
    { Codigo => "03", Descripcion => "Costa de Almeia" },
    { Codigo => "04", Descripcion => "Costa Tropical (Granada)" },
    { Codigo => "05", Descripcion => "Costa Blanca (Alicante)" },
    { Codigo => "06", Descripcion => "Mallorca (Baleares)" },
    { Codigo => "07", Descripcion => "Costas de Galicia (La Coruna - Lugo - Pontevedra)" },
    { Codigo => "08", Descripcion => "Tenerife (Canarias)" },
    { Codigo => "09", Descripcion => "Costa de Valencia (Valencia)" },
    { Codigo => "10", Descripcion => "Costa Algarve (Faro)" };

my $response = &response();
my $result = ClubSpain::XML::Olympia::Response::Coast->parse($response);

is_deeply($result, \@expect, 'returned languages');

sub response {
    return <<"";
<?xml version="1.0" encoding="ISO-8859-1"?>
<string xmlns="http://tempuri.org/">
  <Respuesta>
    <Costas>
      <Costa>
        <Codigo>01</Codigo>
        <Descripcion>Costa del Sol (Malaga)</Descripcion>
      </Costa>
      <Costa>
        <Codigo>02</Codigo>
        <Descripcion>Costa de la Luz (Cadiz - Huelva)</Descripcion>
      </Costa>
      <Costa>
        <Codigo>03</Codigo>
        <Descripcion>Costa de Almeia</Descripcion>
      </Costa>
      <Costa>
        <Codigo>04</Codigo>
        <Descripcion>Costa Tropical (Granada)</Descripcion>
      </Costa>
      <Costa>
        <Codigo>05</Codigo>
        <Descripcion>Costa Blanca (Alicante)</Descripcion>
      </Costa>
      <Costa>
        <Codigo>06</Codigo>
        <Descripcion>Mallorca (Baleares)</Descripcion>
      </Costa>
      <Costa>
        <Codigo>07</Codigo>
        <Descripcion>Costas de Galicia (La Coruna - Lugo - Pontevedra)</Descripcion>
      </Costa>
      <Costa>
        <Codigo>08</Codigo>
        <Descripcion>Tenerife (Canarias)</Descripcion>
      </Costa>
      <Costa>
        <Codigo>09</Codigo>
        <Descripcion>Costa de Valencia (Valencia)</Descripcion>
      </Costa>
      <Costa>
        <Codigo>10</Codigo>
        <Descripcion>Costa Algarve (Faro)</Descripcion>
      </Costa>
    </Costas>
  </Respuesta>
</string>


}
