use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::BoardType');
use_ok('ClubSpain::XML::Olympia::Response::BoardType');

my @expect = map new ClubSpain::XML::Olympia::BoardType($_),
    { RegimenCodigo => "AD", RegimenDescripcion => "AD" },
    { RegimenCodigo => "MP", RegimenDescripcion => "MP" },
    { RegimenCodigo => "PC", RegimenDescripcion => "PC" },
    { RegimenCodigo => "SA", RegimenDescripcion => "SA" },
    { RegimenCodigo => "TI", RegimenDescripcion => "TI" };

my $response = &response();
my $result = ClubSpain::XML::Olympia::Response::BoardType->parse($response);

is_deeply($result, \@expect, 'check parse()');

sub response {
    return <<"";
<?xml version="1.0" encoding="utf-8"?>
<string xmlns="http://tempuri.org/">
  <Respuesta>
    <Regimenes>
      <Regimen>
        <RegimenCodigo>AD</RegimenCodigo>
        <RegimenDescripcion>AD</RegimenDescripcion>
      </Regimen>
      <Regimen>
        <RegimenCodigo>MP</RegimenCodigo>
        <RegimenDescripcion>MP</RegimenDescripcion>
      </Regimen>
      <Regimen>
        <RegimenCodigo>PC</RegimenCodigo>
        <RegimenDescripcion>PC</RegimenDescripcion>
      </Regimen>
      <Regimen>
        <RegimenCodigo>SA</RegimenCodigo>
        <RegimenDescripcion>SA</RegimenDescripcion>
      </Regimen>
      <Regimen>
        <RegimenCodigo>TI</RegimenCodigo>
        <RegimenDescripcion>TI</RegimenDescripcion>
      </Regimen>
    </Regimenes>
  </Respuesta>
</string>

}
