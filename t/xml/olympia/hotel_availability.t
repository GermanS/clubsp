use Test::More tests => 30;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::HotelAvailability');

my $option = ClubSpain::XML::Olympia::HotelAvailability::Option->new({
    Observaciones => 'SUPL. CORTA ESTANCIA 2-4 NOCHES'
});

isa_ok($option, 'ClubSpain::XML::Olympia::HotelAvailability::Option');
is($option->Observaciones, 'SUPL. CORTA ESTANCIA 2-4 NOCHES', 'got observaciones');


my $date = ClubSpain::XML::Olympia::HotelAvailability::Date->new({
    Servicio        => "HAB. DBL. MEDIA PENSION",
    CodigoServicio  => "B0002",
    CodigoConcepto  => "2000",
    regimen         => "MP",
    disponible      => "OK",
    precio          => "990.39",
    option          => [ $option ],
});

isa_ok($date, 'ClubSpain::XML::Olympia::HotelAvailability::Date');
is($date->Servicio, 'HAB. DBL. MEDIA PENSION', 'got Servicio');
is($date->CodigoServicio, 'B0002', 'got CodigoServicio');
is($date->CodigoConcepto, '2000', 'got CodigoConcepto');
is($date->regimen, 'MP', 'got regimen');
is($date->disponible, 'OK', 'got disponible');
is($date->precio, '990.39', 'got precio');



my $room = ClubSpain::XML::Olympia::HotelAvailability::Room->new({
    Habitacion  => '1',
    Adultos     => '2',
    ninos       => [ 8 ],
    numhab      => 2,
    date        => [ $date ]
});

isa_ok($room, 'ClubSpain::XML::Olympia::HotelAvailability::Room');
is($room->Habitacion, 1, 'got habitacion');
is($room->Adultos, 2, 'got adultos');
is_deeply($room->ninos, [8], 'got ninos');
is($room->numhab, 2, 'got num hab');
is_deeply($room->date, [$date], 'got date');



my $hotel = ClubSpain::XML::Olympia::HotelAvailability::Hotel->new({
    Codigo          => 'CS000150',
    Nombre          => 'PLAYABONITA Gran Confort',
    CodigoPais      => '00034',
    CodigoProvincia => '029',
    NombreProvincia => 'MALAGA',
    Poblacion       => 'BENALMADENA',
    Categoria       => '4*',
    FechaEntrada    => '01/08/2007',
    FechaSalida     => '05/08/2007',

    room => [ $room ]
});

isa_ok($hotel, 'ClubSpain::XML::Olympia::HotelAvailability::Hotel');
is($hotel->Codigo, 'CS000150', 'got codigo');
is($hotel->Nombre, 'PLAYABONITA Gran Confort', 'got nombre');
is($hotel->CodigoPais, '00034', 'got codigo pais');
is($hotel->CodigoProvincia, '029', 'got codigo provincia');
is($hotel->NombreProvincia, 'MALAGA', 'got nombre provincia');
is($hotel->Poblacion, 'BENALMADENA', 'got poblacion');
is($hotel->Categoria, '4*', 'got categoria');
is($hotel->FechaEntrada, '01/08/2007', 'got fechae ntrada');
is($hotel->FechaSalida, '05/08/2007', 'got fecha salida');
is_deeply($hotel->room, [ $room ],  'got room');



my $object = ClubSpain::XML::Olympia::HotelAvailability->new({
    CodigoPeticion => '2EBB06834B7FA47A47FE',
    hotel => [ $hotel ]
});

isa_ok($object, 'ClubSpain::XML::Olympia::HotelAvailability');
is($object->CodigoPeticion, '2EBB06834B7FA47A47FE', 'got cotigo petition');
is_deeply($object->hotel, [$hotel], 'got hotel');
