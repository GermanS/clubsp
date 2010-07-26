use Test::More tests => 4;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::Country');

my $country = ClubSpain::XML::Olympia::Country->new({
    Codigo_Pais => '00034',
    Nombre_pais => 'Espana',
});

isa_ok($country, 'ClubSpain::XML::Olympia::Country');
is($country->Codigo_Pais, '00034', 'got Cotigo_Pais');
is($country->Nombre_pais, 'Espana', 'got Nombre_Pais');
