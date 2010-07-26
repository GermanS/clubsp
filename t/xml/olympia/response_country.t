use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::Country');
use_ok('ClubSpain::XML::Olympia::Response::Country');

my @expect = map new ClubSpain::XML::Olympia::Country($_),
        { Codigo_Pais => '00034', Nombre_pais => 'Espana' },
        { Codigo_Pais => '00351', Nombre_pais => 'Portugal' };


my $response = &response();
my $result = ClubSpain::XML::Olympia::Response::Country->parse($response);

is_deeply($result, \@expect, 'returned categories');

sub response {
    return <<"";
<?xml version="1.0" encoding="ISO-8859-1"?>
<string xmlns="http://tempuri.org/">
  <Respuesta>
    <Paises>
      <Pais>
        <Codigo_Pais>00034</Codigo_Pais>
        <Nombre_pais>Espana</Nombre_pais>
      </Pais>
      <Pais>
        <Codigo_Pais>00351</Codigo_Pais>
        <Nombre_pais>Portugal</Nombre_pais>
      </Pais>
    </Paises>
  </Respuesta>
</string>


}
