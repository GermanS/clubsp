use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::RoomType');
use_ok('ClubSpain::XML::Olympia::Response::RoomType');


my @expect = map new ClubSpain::XML::Olympia::RoomType($_),
    { CodigoTipoHabitacion => "2000", DescripcionTipoHabitacion => "HAB DOBLE ESTANDAR" },
    { CodigoTipoHabitacion => "2001", DescripcionTipoHabitacion => "HAB INDIVIDUAL ESTANDAR" },
    { CodigoTipoHabitacion => "2002", DescripcionTipoHabitacion => "HAB DOBLE COMUNICADA" },
    { CodigoTipoHabitacion => "2003", DescripcionTipoHabitacion => "HAB JUNIOR SUITE" };

my $response = &response();
my $result = ClubSpain::XML::Olympia::Response::RoomType->parse($response);

is_deeply($result, \@expect, 'check parse() ');

sub response {
    return <<"";
<?xml version="1.0" encoding="ISO-8859-1"?>
<string xmlns="http://tempuri.org/">
  <Respuesta>
    <TiposHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2000</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>HAB DOBLE ESTANDAR</DescripcionTipoHabitacion>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2001</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>HAB INDIVIDUAL ESTANDAR</DescripcionTipoHabitacion>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2002</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>HAB DOBLE COMUNICADA</DescripcionTipoHabitacion>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2003</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>HAB JUNIOR SUITE</DescripcionTipoHabitacion>
      </TipoHabitacion>
    </TiposHabitacion>
  </Respuesta>
</string>


}
