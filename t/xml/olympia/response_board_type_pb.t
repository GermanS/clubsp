use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::BoardTypePB');
use_ok('ClubSpain::XML::Olympia::Response::BoardTypePB');

my @expect = map new ClubSpain::XML::Olympia::BoardTypePB($_),
    { RegimenCodigo => "AD", TraduccionTexto => "BED AND BREAKFAST" },
    { RegimenCodigo => "ALL", TraduccionTexto => "ALL REGIMES" },
    { RegimenCodigo => "MP", TraduccionTexto => "HALF BOARD" },
    { RegimenCodigo => "PC", TraduccionTexto => "FULL BOARD" },
    { RegimenCodigo => "SA", TraduccionTexto => "ONLY BED" },
    { RegimenCodigo => "TI", TraduccionTexto => "ALL INCLUSIVE" };

my $response = &response();
my $result = ClubSpain::XML::Olympia::Response::BoardTypePB->parse($response);

is_deeply($result, \@expect, 'check parse() ');

sub response {
    return <<"";
<?xml version="1.0" encoding="utf-8"?>
<string xmlns="http://tempuri.org/">
  <Respuesta>
    <Regimenes>
      <Regimen>
        <RegimenCodigo>AD</RegimenCodigo>
        <TraduccionTexto>BED AND BREAKFAST</TraduccionTexto>
      </Regimen>
      <Regimen>
        <RegimenCodigo>ALL</RegimenCodigo>
        <TraduccionTexto>ALL REGIMES</TraduccionTexto>
      </Regimen>
      <Regimen>
        <RegimenCodigo>MP</RegimenCodigo>
        <TraduccionTexto>HALF BOARD</TraduccionTexto>
      </Regimen>
      <Regimen>
        <RegimenCodigo>PC</RegimenCodigo>
        <TraduccionTexto>FULL BOARD</TraduccionTexto>
      </Regimen>
      <Regimen>
        <RegimenCodigo>SA</RegimenCodigo>
        <TraduccionTexto>ONLY BED</TraduccionTexto>
      </Regimen>
      <Regimen>
        <RegimenCodigo>TI</RegimenCodigo>
        <TraduccionTexto>ALL INCLUSIVE</TraduccionTexto>
      </Regimen>
    </Regimenes>
  </Respuesta>
</string>

}
