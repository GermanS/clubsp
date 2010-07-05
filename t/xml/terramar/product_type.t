use Test::More tests => 1;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::ProductType');

my $type = ClubSpain::XML::Terramar::ProductType->new({
    id_tipo_articulo_clase  => 1,
    id_tipo_menu            => 2,
    articulo_clase          => 3,
    busqueda_predeterminada => 4,
    zona_predeterminada     => 5,
    regimen_predeterminado  => 6,
    orden                   => 7,
    visible_minorista       => 8,
    filtros_busqueda_diferencia_dias => 9,
});
