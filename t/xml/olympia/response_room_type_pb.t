use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::RoomTypePB');
use_ok('ClubSpain::XML::Olympia::Response::RoomTypePB');

my @expect = &expect();
my $response = &response();

my $result = ClubSpain::XML::Olympia::Response::RoomTypePB->parse($response);

is_deeply($result, \@expect, 'check parse()');

sub response {
    return <<"";
<?xml version="1.0" encoding="utf-8"?>
<string xmlns="http://tempuri.org/">
  <Respuesta>
    <TiposHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2000</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Doble Estandar</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2001</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Individual Estandar</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2002</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Doble Comunicada</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2003</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Junior Suite</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2004</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Apartamento 1 Dormitorio</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>Y</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2005</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Apartamento 2 Dormitorios</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>Y</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2006</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Apartamento 3 Dormitorios</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>Y</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2007</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Estudio</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>Y</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2008</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Habitacion Familiar</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2009</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Suit Ludica</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2010</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Suit Familiar</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2011</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Duplex</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2012</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Suit Presidencial</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2013</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Habitacion Cuadruple</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2014</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Habitacion Suit Playa</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2015</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Doble Club Vip</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2016</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Doble Village</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2017</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Individual Club Vip</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2018</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Individual Village</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2019</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Doble Superior</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2020</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Individual Superior</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2021</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Suit Junior Individual</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2022</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Doble con Terraza</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2023</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Individual con Terraza</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2024</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Doble uso individual</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2025</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Suit Senior</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2026</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Junior Suit Village</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2027</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Doble Vista Mar</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2028</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Individual Vista Mar</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2029</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Suit de Lujo</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2030</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Junior Suit Superior</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2031</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Junior Suit Diplomaticas</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2032</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Habitacion Doble Larga</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2033</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Habitacion Familiar Doble</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2034</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Doble mas Salon</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2035</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Suit Majestic</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2036</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Suplemento para ninos</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2037</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Suplemento para adultos</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2038</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Gran Suit</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2039</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Bungalow</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>Y</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2040</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Doble Deluxe</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2041</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Individual Deluxe</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2042</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Suit Deluxe</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2043</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Doble Diamante</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2044</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Individual Diamante</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2045</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Suit Diamante</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2046</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Suit Real</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2047</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Atico</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2048</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Doble Familiar Vista Mar</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2049</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Junior Suit Vista Mar</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2050</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Suit</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2051</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Master Suit</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2052</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Suit Superior Individual</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2053</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Apartamento 1 Dormitorio con Regimen</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2054</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Apartamento 2 dormitorios con Regimen</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2055</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Estudio con Regimen</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2056</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Suite Unidad/Dia</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>Y</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2057</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Apartamento 3 Dormitorios con Regimen</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2058</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Bungalow con Regimen</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2059</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Descuento 1st ninos</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2060</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Descuento 2nd ninos</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2061</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Descuento 3rd ninos</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2062</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Descuento 4th ninos</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2063</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Descuento 5th ninos</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2064</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Descuento 6th ninos</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2065</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Descuento 3rd pax</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2066</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Descuento 4th pax</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2067</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Descuento 5th pax</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2068</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Descuento 6th pax</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2069</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Descuento 2nd pax</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2100</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Habitacion Unidad/Dia</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>Y</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2500</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Suplementos/Descuentos varios</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2600</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Gastos de cancelacion</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>2700</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Especial Suplementos/Descuentos</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>3000</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Spto Corta Estancia</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
      <TipoHabitacion>
        <CodigoTipoHabitacion>3001</CodigoTipoHabitacion>
        <DescripcionTipoHabitacion>Dto Porcentaje Global</DescripcionTipoHabitacion>
        <ApartamentoTipoReserva>N</ApartamentoTipoReserva>
      </TipoHabitacion>
    </TiposHabitacion>
  </Respuesta>
</string>


}

sub expect {
    return  map new ClubSpain::XML::Olympia::RoomTypePB($_),
    {
CodigoTipoHabitacion => "2000",
DescripcionTipoHabitacion => "Doble Estandar",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2001",
DescripcionTipoHabitacion => "Individual Estandar",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2002",
DescripcionTipoHabitacion => "Doble Comunicada",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2003",
DescripcionTipoHabitacion => "Junior Suite",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2004",
DescripcionTipoHabitacion => "Apartamento 1 Dormitorio",
ApartamentoTipoReserva => "Y"
},
{
CodigoTipoHabitacion => "2005",
DescripcionTipoHabitacion => "Apartamento 2 Dormitorios",
ApartamentoTipoReserva => "Y"
},
{
CodigoTipoHabitacion => "2006",
DescripcionTipoHabitacion => "Apartamento 3 Dormitorios",
ApartamentoTipoReserva => "Y"
},
{
CodigoTipoHabitacion => "2007",
DescripcionTipoHabitacion => "Estudio",
ApartamentoTipoReserva => "Y"
},
{
CodigoTipoHabitacion => "2008",
DescripcionTipoHabitacion => "Habitacion Familiar",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2009",
DescripcionTipoHabitacion => "Suit Ludica",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2010",
DescripcionTipoHabitacion => "Suit Familiar",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2011",
DescripcionTipoHabitacion => "Duplex",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2012",
DescripcionTipoHabitacion => "Suit Presidencial",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2013",
DescripcionTipoHabitacion => "Habitacion Cuadruple",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2014",
DescripcionTipoHabitacion => "Habitacion Suit Playa",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2015",
DescripcionTipoHabitacion => "Doble Club Vip",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2016",
DescripcionTipoHabitacion => "Doble Village",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2017",
DescripcionTipoHabitacion => "Individual Club Vip",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2018",
DescripcionTipoHabitacion => "Individual Village",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2019",
DescripcionTipoHabitacion => "Doble Superior",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2020",
DescripcionTipoHabitacion => "Individual Superior",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2021",
DescripcionTipoHabitacion => "Suit Junior Individual",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2022",
DescripcionTipoHabitacion => "Doble con Terraza",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2023",
DescripcionTipoHabitacion => "Individual con Terraza",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2024",
DescripcionTipoHabitacion => "Doble uso individual",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2025",
DescripcionTipoHabitacion => "Suit Senior",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2026",
DescripcionTipoHabitacion => "Junior Suit Village",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2027",
DescripcionTipoHabitacion => "Doble Vista Mar",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2028",
DescripcionTipoHabitacion => "Individual Vista Mar",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2029",
DescripcionTipoHabitacion => "Suit de Lujo",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2030",
DescripcionTipoHabitacion => "Junior Suit Superior",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2031",
DescripcionTipoHabitacion => "Junior Suit Diplomaticas",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2032",
DescripcionTipoHabitacion => "Habitacion Doble Larga",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2033",
DescripcionTipoHabitacion => "Habitacion Familiar Doble",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2034",
DescripcionTipoHabitacion => "Doble mas Salon",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2035",
DescripcionTipoHabitacion => "Suit Majestic",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2036",
DescripcionTipoHabitacion => "Suplemento para ninos",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2037",
DescripcionTipoHabitacion => "Suplemento para adultos",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2038",
DescripcionTipoHabitacion => "Gran Suit",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2039",
DescripcionTipoHabitacion => "Bungalow",
ApartamentoTipoReserva => "Y"
},
{
CodigoTipoHabitacion => "2040",
DescripcionTipoHabitacion => "Doble Deluxe",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2041",
DescripcionTipoHabitacion => "Individual Deluxe",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2042",
DescripcionTipoHabitacion => "Suit Deluxe",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2043",
DescripcionTipoHabitacion => "Doble Diamante",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2044",
DescripcionTipoHabitacion => "Individual Diamante",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2045",
DescripcionTipoHabitacion => "Suit Diamante",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2046",
DescripcionTipoHabitacion => "Suit Real",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2047",
DescripcionTipoHabitacion => "Atico",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2048",
DescripcionTipoHabitacion => "Doble Familiar Vista Mar",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2049",
DescripcionTipoHabitacion => "Junior Suit Vista Mar",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2050",
DescripcionTipoHabitacion => "Suit",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2051",
DescripcionTipoHabitacion => "Master Suit",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2052",
DescripcionTipoHabitacion => "Suit Superior Individual",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2053",
DescripcionTipoHabitacion => "Apartamento 1 Dormitorio con Regimen",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2054",
DescripcionTipoHabitacion => "Apartamento 2 dormitorios con Regimen",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2055",
DescripcionTipoHabitacion => "Estudio con Regimen",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2056",
DescripcionTipoHabitacion => "Suite Unidad/Dia",
ApartamentoTipoReserva => "Y"
},
{
CodigoTipoHabitacion => "2057",
DescripcionTipoHabitacion => "Apartamento 3 Dormitorios con Regimen",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2058",
DescripcionTipoHabitacion => "Bungalow con Regimen",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2059",
DescripcionTipoHabitacion => "Descuento 1st ninos",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2060",
DescripcionTipoHabitacion => "Descuento 2nd ninos",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2061",
DescripcionTipoHabitacion => "Descuento 3rd ninos",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2062",
DescripcionTipoHabitacion => "Descuento 4th ninos",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2063",
DescripcionTipoHabitacion => "Descuento 5th ninos",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2064",
DescripcionTipoHabitacion => "Descuento 6th ninos",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2065",
DescripcionTipoHabitacion => "Descuento 3rd pax",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2066",
DescripcionTipoHabitacion => "Descuento 4th pax",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2067",
DescripcionTipoHabitacion => "Descuento 5th pax",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2068",
DescripcionTipoHabitacion => "Descuento 6th pax",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2069",
DescripcionTipoHabitacion => "Descuento 2nd pax",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2100",
DescripcionTipoHabitacion => "Habitacion Unidad/Dia",
ApartamentoTipoReserva => "Y"
},
{
CodigoTipoHabitacion => "2500",
DescripcionTipoHabitacion => "Suplementos/Descuentos varios",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2600",
DescripcionTipoHabitacion => "Gastos de cancelacion",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "2700",
DescripcionTipoHabitacion => "Especial Suplementos/Descuentos",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "3000",
DescripcionTipoHabitacion => "Spto Corta Estancia",
ApartamentoTipoReserva => "N"
},
{
CodigoTipoHabitacion => "3001",
DescripcionTipoHabitacion => "Dto Porcentaje Global",
ApartamentoTipoReserva => "N"
};


}
