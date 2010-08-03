use Test::More tests => 2;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::Request::HotelAvailability');

my $expected = &request();
my $content = ClubSpain::XML::Olympia::Request::HotelAvailability->request(
    user      => 7777,
    password  => 8888,
    pais      => '00034',
    provincia => '029',
    poblacion => 11,
    categoria => '4*',
    codigo    => undef,
    fechaentradast => '01/08/07',
    noches => 4,
    adultos => 2,
    ninos => 1,
    edad  => 8,
    regimen => 'MP',
);
is($content, $expected, 'check content');

sub request {
    return <<"";
<?xml version="1.0" encoding="utf-8"?>
<DevuelveDisponibilidadPB xmlns="http://tempuri.org/">
  <User>7777</User>
  <password>8888</password>
  <Pais>00034</Pais>
  <provincia>029</provincia>
  <Poblacion>11</Poblacion>
  <Categoria>4*</Categoria>
  <Codigo/>
  <FechaEntradaSt>01/08/07</FechaEntradaSt>
  <Noches>4</Noches>
  <ListHab>
    <HabitacionesList>
      <Habitacion Ord="1">
        <Adultos>2</Adultos>
        <ninos num="1">
          <edad>8</edad>
        </ninos>
        <Regimen>MP</Regimen>
      </Habitacion>
    </HabitacionesList>
  </ListHab>
  <Opciones/>
</DevuelveDisponibilidadPB>


}
