use Test::More tests => 15;

use strict;
use warnings;

use_ok("ClubSpain::XML::Olympia::Hotel");

my $hotel = ClubSpain::XML::Olympia::Hotel->new({
        Codigo => 'CS000160',
        Nombre => 'SAN FERMIN',
        Direccion => 'AVDA. SAN FERMIN, 11',
        Telefono => '952577171',
        Email => 'reservas@hotelalay.com',
        Pais => '00034',
        NombrePais => 'Espana',
        Provincia => '029',
        NombreProvincia => 'MALAGA',
        Poblacion => '11',
        NombrePoblacion => 'BENALMADENA',
        Descripcion => 'Situacion: a 300m de la playa',
        Categoria => '3*'
});

isa_ok($hotel, 'ClubSpain::XML::Olympia::Hotel');
is($hotel->Codigo, 'CS000160', 'got codigo');
is($hotel->Nombre , 'SAN FERMIN', 'got Nombre');
is($hotel->Direccion , 'AVDA. SAN FERMIN, 11', 'got Direccion');
is($hotel->Telefono , '952577171', 'got Telefono');
is($hotel->Email , 'reservas@hotelalay.com', 'got Email');
is($hotel->Pais , '00034', 'got Pais');
is($hotel->NombrePais , 'Espana', 'got NombrePais');
is($hotel->Provincia , '029', 'got Provincia');
is($hotel->NombreProvincia , 'MALAGA', 'got NombreProvincia');
is($hotel->Poblacion , '11', 'got Poblacion');
is($hotel->NombrePoblacion , 'BENALMADENA', 'got NombrePoblacion');
is($hotel->Descripcion , 'Situacion: a 300m de la playa', 'got Descripcion');
is($hotel->Categoria , '3*', 'got Categoria');
