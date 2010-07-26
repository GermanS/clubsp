use Test::More tests => 6;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::City');

my $city = ClubSpain::XML::Olympia::City->new({
    Pais_Codigo      => '00034',
    Provincia_Codigo => '029',
    Poblacion_Codigo => '11',
    Poblacion_Nombre => 'BENALMADENA',
});

isa_ok($city, 'ClubSpain::XML::Olympia::City');

is($city->Pais_Codigo, '00034', 'got pais codigo');
is($city->Provincia_Codigo, '029', 'pot provincia codigo');
is($city->Poblacion_Codigo, '11', 'got poblacion codigo');
is($city->Poblacion_Nombre, 'BENALMADENA', 'got poblacion nambre');
