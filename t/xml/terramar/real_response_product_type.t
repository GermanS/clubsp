use Test::More tests => 3;

use strict;
use warnings;

use File::Slurp;

use_ok('ClubSpain::XML::Terramar::ProductType');
use_ok('ClubSpain::XML::Terramar::Response::ProductType');

my $xml = read_file('t/var/terramar/response_product_type.xml');
my $result = ClubSpain::XML::Terramar::Response::ProductType->parse($xml);

is_deeply($result, &expected(), 'compare objects');

sub expected {
    my @expect = ({
        id_tipo_articulo_clase => 2,
        id_tipo_menu => 8,
        articulo_clase => 'HOTEL',
        busqueda_predeterminada => 'buscar hotel xml',
        zona_predeterminada => 'BARCELONA',
        regimen_predeterminado => "",
        orden => 2,
        visible_minorista =>1,
        filtros_busqueda_diferencia_dias =>3
    });

    my @objects;
    push @objects, new ClubSpain::XML::Terramar::ProductType($_)
        foreach (@expect);

    return \@objects;
}

