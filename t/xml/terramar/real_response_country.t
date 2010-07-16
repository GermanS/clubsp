use Test::More tests => 3;

use strict;
use warnings;
use File::Slurp;

use_ok('ClubSpain::XML::Terramar::Country');
use_ok('ClubSpain::XML::Terramar::Response::Country');

my $xml = read_file('t/var/terramar/response_country.xml');
my $result = ClubSpain::XML::Terramar::Response::Country->parse($xml);

is_deeply($result, &expected(), 'compare objects');



sub expected {
    my @expect = ({
    id_zona_pais => 84,
    nombre => 'ALBANIA'
  },
  {
    id_zona_pais => 18,
    nombre => 'ALEMANIA'
  },
  {
    id_zona_pais => 7,
    nombre => 'ANDORRA'
  },
  {
    id_zona_pais => 183,
    nombre => 'ANGOLA'
  },
  {
    id_zona_pais => 159,
    nombre => 'ANTIGUA Y BARBUDA'
  },
  {
    id_zona_pais => 86,
    nombre => 'ANTILLAS DE PAISES BAJOS'
  },
  {
    id_zona_pais => 138,
    nombre => 'ARABIA SAUD'
  },
  {
    id_zona_pais => 185,
    nombre => 'ARGELIA'
  },
  {
    id_zona_pais => 58,
    nombre => 'ARGENTINA'
  },
  {
    id_zona_pais => 87,
    nombre => 'ARUBA'
  },
  {
    id_zona_pais => 57,
    nombre => 'AUSTRALIA'
  },
  {
    id_zona_pais => 10,
    nombre => 'AUSTRIA'
  },
  {
    id_zona_pais => 181,
    nombre => 'BAHAMAS'
  },
  {
    id_zona_pais => 91,
    nombre => 'BAHREIN'
  },
  {
    id_zona_pais => 89,
    nombre => 'BARBADOS'
  },
  {
    id_zona_pais => 11,
    nombre => 'BELGICA'
  },
  {
    id_zona_pais => 186,
    nombre => 'BELICE'
  },
  {
    id_zona_pais => 187,
    nombre => 'BERMUDAS'
  },
  {
    id_zona_pais => 95,
    nombre => 'BIELORRUSIA'
  },
  {
    id_zona_pais => 189,
    nombre => 'BIRMANIA - MYANMAR'
  },
  {
    id_zona_pais => 75,
    nombre => 'BOLIVIA'
  },
  {
    id_zona_pais => 286,
    nombre => 'BOSNIA HERZEGOVINA'
  },
  {
    id_zona_pais => 172,
    nombre => 'BOSNIA-HERZEGOVINA'
  },
  {
    id_zona_pais => 13,
    nombre => 'BRASIL'
  },
  {
    id_zona_pais => 190,
    nombre => 'BRUNEI'
  },
  {
    id_zona_pais => 12,
    nombre => 'BULGARIA'
  },
  {
    id_zona_pais => 191,
    nombre => 'BURKINA FASO'
  },
  {
    id_zona_pais => 161,
    nombre => 'CABO VERDE'
  },
  {
    id_zona_pais => 31,
    nombre => 'CAMBOYA'
  },
  {
    id_zona_pais => 64,
    nombre => 'CANADA'
  },
  {
    id_zona_pais => 60,
    nombre => 'CHILE'
  },
  {
    id_zona_pais => 73,
    nombre => 'CHINA'
  },
  {
    id_zona_pais => 17,
    nombre => 'CHIPRE'
  },
  {
    id_zona_pais => 65,
    nombre => 'COLOMBIA'
  },
  {
    id_zona_pais => 115,
    nombre => 'COREA DEL SUR'
  },
  {
    id_zona_pais => 15,
    nombre => 'COSTA RICA'
  },
  {
    id_zona_pais => 25,
    nombre => 'CROACIA'
  },
  {
    id_zona_pais => 16,
    nombre => 'CUBA'
  },
  {
    id_zona_pais => 19,
    nombre => 'DINAMARCA'
  },
  {
    id_zona_pais => 195,
    nombre => 'DJIBOUTI'
  },
  {
    id_zona_pais => 71,
    nombre => 'ECUADOR'
  },
  {
    id_zona_pais => 22,
    nombre => 'EGIPTO'
  },
  {
    id_zona_pais => 81,
    nombre => 'EL SALVADOR'
  },
  {
    id_zona_pais => 9,
    nombre => 'EMIRATOS ARABES UNIDOS'
  },
  {
    id_zona_pais => 50,
    nombre => 'ESLOVAQUIA'
  },
  {
    id_zona_pais => 49,
    nombre => 'ESLOVENIA'
  },
  {
    id_zona_pais => 1,
    nombre => 'SPAIN'
  },
  {
    id_zona_pais => 21,
    nombre => 'ESTONIA'
  },
  {
    id_zona_pais => 174,
    nombre => 'FILIPINAS'
  },
  {
    id_zona_pais => 23,
    nombre => 'FINLANDIA'
  },
  {
    id_zona_pais => 8,
    nombre => 'FRANCIA'
  },
  {
    id_zona_pais => 104,
    nombre => 'GAMBIA'
  },
  {
    id_zona_pais => 198,
    nombre => 'GHANA'
  },
  {
    id_zona_pais => 4,
    nombre => 'GRAN BRETANA'
  },
  {
    id_zona_pais => 100,
    nombre => 'GRANADA'
  },
  {
    id_zona_pais => 24,
    nombre => 'GRECIA'
  },
  {
    id_zona_pais => 66,
    nombre => 'GUATEMALA'
  },
  {
    id_zona_pais => 43,
    nombre => 'HOLANDA'
  },
  {
    id_zona_pais => 77,
    nombre => 'HONDURAS'
  },
  {
    id_zona_pais => 107,
    nombre => 'HONG KONG'
  },
  {
    id_zona_pais => 26,
    nombre => 'HUNGRIA'
  },
  {
    id_zona_pais => 74,
    nombre => 'INDIA'
  },
  {
    id_zona_pais => 27,
    nombre => 'INDONESIA'
  },
  {
    id_zona_pais => 111,
    nombre => 'IRAN'
  },
  {
    id_zona_pais => 28,
    nombre => 'IRLANDA'
  },
  {
    id_zona_pais => 202,
    nombre => 'ISLA REUNION [FRANCIA]'
  },
  {
    id_zona_pais => 29,
    nombre => 'ISLANDIA'
  },
  {
    id_zona_pais => 117,
    nombre => 'ISLAS CAIMAN'
  },
  {
    id_zona_pais => 76,
    nombre => 'ISLAS FIJI'
  },
  {
    id_zona_pais => 175,
    nombre => 'ISLAS MAURICIO'
  },
  {
    id_zona_pais => 176,
    nombre => 'ISLAS TURCAS Y CAICOS [UK]'
  },
  {
    id_zona_pais => 177,
    nombre => 'ISLAS VIRGENES [EEUU]'
  },
  {
    id_zona_pais => 109,
    nombre => 'ISRAEL'
  },
  {
    id_zona_pais => 2,
    nombre => 'ITALIA'
  },
  {
    id_zona_pais => 83,
    nombre => 'JAMAICA'
  },
  {
    id_zona_pais => 70,
    nombre => 'JAPON'
  },
  {
    id_zona_pais => 30,
    nombre => 'JORDANIA'
  },
  {
    id_zona_pais => 118,
    nombre => 'KAZAJSTAN'
  },
  {
    id_zona_pais => 282,
    nombre => 'KENIA'
  },
  {
    id_zona_pais => 116,
    nombre => 'KUWAIT'
  },
  {
    id_zona_pais => 32,
    nombre => 'LAOS'
  },
  {
    id_zona_pais => 37,
    nombre => 'LETONIA'
  },
  {
    id_zona_pais => 119,
    nombre => 'LIBANO'
  },
  {
    id_zona_pais => 121,
    nombre => 'LIBIA'
  },
  {
    id_zona_pais => 33,
    nombre => 'LIECHTENSTEIN'
  },
  {
    id_zona_pais => 35,
    nombre => 'LITUANIA'
  },
  {
    id_zona_pais => 36,
    nombre => 'LUXEMBURGO'
  },
  {
    id_zona_pais => 126,
    nombre => 'MACAU'
  },
  {
    id_zona_pais => 211,
    nombre => 'MADAGASCAR'
  },
  {
    id_zona_pais => 67,
    nombre => 'MALASIA'
  },
  {
    id_zona_pais => 212,
    nombre => 'MALAWI'
  },
  {
    id_zona_pais => 124,
    nombre => 'MALI'
  },
  {
    id_zona_pais => 41,
    nombre => 'MALTA'
  },
  {
    id_zona_pais => 38,
    nombre => 'MARRUECOS'
  },
  {
    id_zona_pais => 213,
    nombre => 'MARTINICA [FRANCIA]'
  },
  {
    id_zona_pais => 42,
    nombre => 'MEXICO'
  },
  {
    id_zona_pais => 122,
    nombre => 'MOLDAVIA'
  },
  {
    id_zona_pais => 39,
    nombre => 'MONACO'
  },
  {
    id_zona_pais => 129,
    nombre => 'MOZAMBIQUE'
  },
  {
    id_zona_pais => 130,
    nombre => 'NAMIBIA'
  },
  {
    id_zona_pais => 80,
    nombre => 'NEPAL'
  },
  {
    id_zona_pais => 79,
    nombre => 'NICARAGUA'
  },
  {
    id_zona_pais => 44,
    nombre => 'NORUEGA'
  },
  {
    id_zona_pais => 179,
    nombre => 'NUEVA CALEDONIA [FRANCIA]'
  },
  {
    id_zona_pais => 61,
    nombre => 'NUEVA ZELANDA'
  },
  {
    id_zona_pais => 132,
    nombre => 'OMAN'
  },
  {
    id_zona_pais => 72,
    nombre => 'PANAMA'
  },
  {
    id_zona_pais => 136,
    nombre => 'PARAGUAY'
  },
  {
    id_zona_pais => 69,
    nombre => 'PERU'
  },
  {
    id_zona_pais => 133,
    nombre => 'POLINESIA FRANCESA'
  },
  {
    id_zona_pais => 46,
    nombre => 'POLONIA'
  },
  {
    id_zona_pais => 3,
    nombre => 'PORTUGAL'
  },
  {
    id_zona_pais => 82,
    nombre => 'PUERTO RICO'
  },
  {
    id_zona_pais => 137,
    nombre => 'QATAR'
  },
  {
    id_zona_pais => 56,
    nombre => 'REPUBLICA CHECA'
  },
  {
    id_zona_pais => 20,
    nombre => 'REPUBLICA DOMINICANA'
  },
  {
    id_zona_pais => 222,
    nombre => 'RUANDA'
  },
  {
    id_zona_pais => 47,
    nombre => 'RUMANIA'
  },
  {
    id_zona_pais => 169,
    nombre => 'RUSIA'
  },
  {
    id_zona_pais => 165,
    nombre => 'SAN MARINO'
  },
  {
    id_zona_pais => 155,
    nombre => 'SAN MARTIN (F)'
  },
  {
    id_zona_pais => 152,
    nombre => 'SAN VICENTE Y LAS GRANADINAS'
  },
  {
    id_zona_pais => 120,
    nombre => 'SANTA LUCIA'
  },
  {
    id_zona_pais => 140,
    nombre => 'SENEGAL'
  },
  {
    id_zona_pais => 55,
    nombre => 'SERBIA MONTENEGRO'
  },
  {
    id_zona_pais => 180,
    nombre => 'SEYCHELLES'
  },
  {
    id_zona_pais => 68,
    nombre => 'SINGAPUR'
  },
  {
    id_zona_pais => 141,
    nombre => 'SIRIA'
  },
  {
    id_zona_pais => 34,
    nombre => 'SRI LANKA'
  },
  {
    id_zona_pais => 171,
    nombre => 'SUDAFRICA'
  },
  {
    id_zona_pais => 48,
    nombre => 'SUECIA'
  },
  {
    id_zona_pais => 14,
    nombre => 'SUIZA'
  },
  {
    id_zona_pais => 51,
    nombre => 'TAILANDIA'
  },
  {
    id_zona_pais => 148,
    nombre => 'TAIWAN'
  },
  {
    id_zona_pais => 149,
    nombre => 'TANZANIA'
  },
  {
    id_zona_pais => 147,
    nombre => 'TRINIDAD Y TOBAGO'
  },
  {
    id_zona_pais => 52,
    nombre => 'TUNEZ'
  },
  {
    id_zona_pais => 53,
    nombre => 'TURQUIA'
  },
  {
    id_zona_pais => 150,
    nombre => 'UCRANIA'
  },
  {
    id_zona_pais => 151,
    nombre => 'UGANDA'
  },
  {
    id_zona_pais => 63,
    nombre => 'URUGUAY'
  },
  {
    id_zona_pais => 59,
    nombre => 'USA'
  },
  {
    id_zona_pais => 153,
    nombre => 'VANUATU'
  },
  {
    id_zona_pais => 62,
    nombre => 'VENEZUELA'
  },
  {
    id_zona_pais => 54,
    nombre => 'VIETNAM'
  },
  {
    id_zona_pais => 232,
    nombre => 'YEMEN'
  },
  {
    id_zona_pais => 157,
    nombre => 'ZAMBIA'
  });  
  
    my @objects;
    push @objects, new ClubSpain::XML::Terramar::Country($_)
        foreach (@expect);
      
    return \@objects;
}
