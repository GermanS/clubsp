use Test::More tests => 3;

use strict;
use warnings;

use File::Slurp;

use_ok('ClubSpain::XML::Terramar::Zona');
use_ok('ClubSpain::XML::Terramar::Response::Zona');

my $xml = read_file('t/var/terramar/response_zone.xml');
my $result = ClubSpain::XML::Terramar::Response::Zona->parse($xml);

is_deeply($result, &expected(), 'compare objects');

sub expected {
    my @expect = ({
        id_zona => 64,
        nombre => "A CORUNA",
    },
    {
        id_zona => 65,
        nombre => "ALAVA",
    },
    {
        id_zona => 66,
        nombre => "ALBACETE",
    },
    {
        id_zona => 68,
        nombre => "ALMERIA",
    },
    {
        id_zona => 69,
        nombre => "ASTURIAS",
    },
    {
        id_zona => 70,
        nombre => "AVILA",
    },
    {
        id_zona => 71,
        nombre => "BADAJOZ",
    },
    {
        id_zona => 1326,
        nombre => "BAQUEIRA-BERET",
    },
    {
        id_zona => 73,
        nombre => "BARCELONA",
    },
    {
        id_zona => 1296,
        nombre => "BENAVENTE",
    },
    {
        id_zona => 1297,
        nombre => "BURGILLOS",
    },
    {
        id_zona => 74,
        nombre => "BURGOS",
    },
    {
        id_zona => 75,
        nombre => "CACERES",
    },
    {
        id_zona => 77,
        nombre => "CANARIAS",
    },
    {
        id_zona => 78,
        nombre => "CANTABRIA",
    },
    {
        id_zona => 1287,
        nombre => "CARTAGENA",
    },
    {
        id_zona => 79,
        nombre => "CASTELLON",
    },
    {
        id_zona => 80,
        nombre => "CEUTA",
    },
    {
        id_zona => 81,
        nombre => "CIUDAD REAL",
    },
    {
        id_zona => 82,
        nombre => "CORDOBA",
    },
    {
        id_zona => 1314,
        nombre => "COSTA AZAHAR",
    },
    {
        id_zona => 1318,
        nombre => "COSTA BLANCA",
    },
    {
        id_zona => 1322,
        nombre => "COSTA BRAVA",
    },
    {
        id_zona => 1317,
        nombre => "COSTA DEL SOL",
    },
    {
        id_zona => 1323,
        nombre => "COSTA DORADA",
    },
    {
        id_zona => 1324,
        nombre => "COSTA GARAF",
    },
    {
        id_zona => 83,
        nombre => "CUENCA",
    },
    {
        id_zona => 673,
        nombre => "ESPANA",
    },
    {
        id_zona => 1315,
        nombre => "FUERTEVENTURA",
    },
    {
        id_zona => 85,
        nombre => "GIRONA",
    },
    {
        id_zona => 1316,
        nombre => "GRAN CANARIA",
    },
    {
        id_zona => 87,
        nombre => "GRANADA",
    },
    {
        id_zona => 88,
        nombre => "GUADALAJARA",
    },
    {
        id_zona => 89,
        nombre => "GUIPOZCOA",
    },
    {
        id_zona => 90,
        nombre => "HUELVA",
    },
    {
        id_zona => 91,
        nombre => "HUESCA",
    },
    {
        id_zona => 645,
        nombre => "IBIZA",
    },
    {
        id_zona => 93,
        nombre => "JAEN",
    },
    {
        id_zona => 1308,
        nombre => "LA GOMERA",
    },
    {
        id_zona => 94,
        nombre => "LA RIOJA",
    },
    {
        id_zona => 1320,
        nombre => "LANZAROTE",
    },
    {
        id_zona => 97,
        nombre => "LEON",
    },
    {
        id_zona => 98,
        nombre => "LLEIDA",
    },
    {
        id_zona => 99,
        nombre => "LUGO",
    },
    {
        id_zona => 100,
        nombre => "MADRID",
    },
    {
        id_zona => 1321,
        nombre => "MALLORCA",
    },
    {
        id_zona => 1352,
        nombre => "MANACOR",
    },
    {
        id_zona => 102,
        nombre => "MELILLA",
    },
    {
        id_zona => 590,
        nombre => "MENORCA",
    },
    {
        id_zona => 103,
        nombre => "MURCIA",
    },
    {
        id_zona => 647,
        nombre => "NA XAMENA/SAN MIGUEL",
    },
    {
        id_zona => 104,
        nombre => "NAVARRA",
    },
    {
        id_zona => 105,
        nombre => "ORENSE",
    },
    {
        id_zona => 106,
        nombre => "PALENCIA",
    },
    {
        id_zona => 107,
        nombre => "PONTEVEDRA",
    },
    {
        id_zona => 641,
        nombre => "SA COMA",
    },
    {
        id_zona => 109,
        nombre => "SALAMANCA",
    },
    {
        id_zona => 650,
        nombre => "SAN JOSE",
    },
    {
        id_zona => 111,
        nombre => "SEGOVIA",
    },
    {
        id_zona => 112,
        nombre => "SEVILLA",
    },
    {
        id_zona => 1290,
        nombre => "SIERRA NEVADA",
    },
    {
        id_zona => 113,
        nombre => "SORIA",
    },
    {
        id_zona => 114,
        nombre => "TARRAGONA",
    },
    {
        id_zona => 1319,
        nombre => "TENERIFE",
    },
    {
        id_zona => 116,
        nombre => "TERUEL",
    },
    {
        id_zona => 117,
        nombre => "TOLEDO",
    },
    {
        id_zona => 118,
        nombre => "VALENCIA",
    },
    {
        id_zona => 119,
        nombre => "VALLADOLID",
    },
    {
        id_zona => 120,
        nombre => "VIZCAYA",
    },
    {
        id_zona => 121,
        nombre => "ZAMORA",
    },
    {
        id_zona => 122,
        nombre => "ZARAGOZA",
    });

    my @objects;
    push @objects, new ClubSpain::XML::Terramar::Zona($_)
        foreach (@expect);

    return \@objects;
}
