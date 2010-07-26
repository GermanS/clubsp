use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::Category');
use_ok('ClubSpain::XML::Olympia::Response::Category');

my @expect = map new ClubSpain::XML::Olympia::Category($_),
        { CodigoCategoria => '1*', NombreCategoria => '1*' },
        { CodigoCategoria => '2*', NombreCategoria => '2*' },
        { CodigoCategoria => '3*', NombreCategoria => '3*' },
        { CodigoCategoria => '4*', NombreCategoria => '4*' },
        { CodigoCategoria => '5*', NombreCategoria => '5*' },
        { CodigoCategoria => 'Apto.1LL', NombreCategoria => 'Apto.1LL' },
        { CodigoCategoria => 'Apto.2LL', NombreCategoria => 'Apto.2LL'},
        { CodigoCategoria => 'Apto.3LL', NombreCategoria => 'Apto.3LL' };

my $response = &response();
my $result = ClubSpain::XML::Olympia::Response::Category->parse($response);

is_deeply($result, \@expect, 'returned categories');

sub response {
    return <<"";
<?xml version="1.0" encoding="utf-8"?>
<string xmlns="http://tempuri.org/">
  <Respuesta>
    <Categorias>
      <Categoria>
        <CodigoCategoria>1*</CodigoCategoria>
        <NombreCategoria>1*</NombreCategoria>
      </Categoria>
      <Categoria>
        <CodigoCategoria>2*</CodigoCategoria>
        <NombreCategoria>2*</NombreCategoria>
      </Categoria>
      <Categoria>
        <CodigoCategoria>3*</CodigoCategoria>
        <NombreCategoria>3*</NombreCategoria>
      </Categoria>
      <Categoria>
        <CodigoCategoria>4*</CodigoCategoria>
        <NombreCategoria>4*</NombreCategoria>
      </Categoria>
      <Categoria>
        <CodigoCategoria>5*</CodigoCategoria>
        <NombreCategoria>5*</NombreCategoria>
      </Categoria>
      <Categoria>
        <CodigoCategoria>Apto.1LL</CodigoCategoria>
        <NombreCategoria>Apto.1LL</NombreCategoria>
      </Categoria>
      <Categoria>
        <CodigoCategoria>Apto.2LL</CodigoCategoria>
        <NombreCategoria>Apto.2LL</NombreCategoria>
      </Categoria>
      <Categoria>
        <CodigoCategoria>Apto.3LL</CodigoCategoria>
        <NombreCategoria>Apto.3LL</NombreCategoria>
      </Categoria>
    </Categorias>
  </Respuesta>
</string>


}
