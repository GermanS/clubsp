use Test::More tests => 5;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::Province');

my $province = ClubSpain::XML::Olympia::Province->new({
    Pais_Codigo      => '00034',
    Provincia_Codigo => '003',
    Provincia_Nombre => 'ALICANTE',
});

isa_ok($province, 'ClubSpain::XML::Olympia::Province');
is($province->Pais_Codigo, '00034', 'got Pais_Codigo');
is($province->Provincia_Codigo, '003', 'got Provincia_Codigo');
is($province->Provincia_Nombre, 'ALICANTE', 'got Provincia_Nombre');
