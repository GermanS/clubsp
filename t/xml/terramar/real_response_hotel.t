use Test::More tests => 3;

use strict;
use warnings;

use File::Slurp;

use_ok('ClubSpain::XML::Terramar::Hotel');
use_ok('ClubSpain::XML::Terramar::Response::Hotel');

my $xml = read_file('t/var/terramar/response_hotel.xml');
my $result = ClubSpain::XML::Terramar::Response::Hotel->parse($xml);

is_deeply($result, &expected(), 'compare objects');

sub expected {
    my @expect = ({
    id_prestatario =>45669,
    nombre_comercial => 'ACUARIO'
  },
  {
    id_prestatario =>72090,
    nombre_comercial => 'AQUA GOLDEN PINEDA APTOS'
  },
  {
    id_prestatario =>45670,
    nombre_comercial => 'AQUAMARINA'
  },
  {
    id_prestatario =>45671,
    nombre_comercial => 'AROMAR (LA PINEDA) APTOS'
  },
  {
    id_prestatario =>36537,
    nombre_comercial => 'BEST SOL D.OR'
  },
  {
    id_prestatario =>72007,
    nombre_comercial => 'CAMPING TORRE DE LA MORA'
  },
  {
    id_prestatario =>45673,
    nombre_comercial => 'CYE 4 Y 5'
  },
  {
    id_prestatario =>45668,
    nombre_comercial => 'CYE MARINA'
  },
  {
    id_prestatario =>46130,
    nombre_comercial => 'ESTIVAL PARK'
  },
  {
    id_prestatario =>46131,
    nombre_comercial => 'ESTIVAL PARK'
  },
  {
    id_prestatario =>46128,
    nombre_comercial => 'HOTEL ESTIVAL PARK APARTAMENTOS'
  },
  {
    id_prestatario =>45674,
    nombre_comercial => 'ESTIVAL PARK'
  },
  {
    id_prestatario =>46132,
    nombre_comercial => 'HOTEL ESTIVAL PARK STANDARD'
  },
  {
    id_prestatario =>72619,
    nombre_comercial => 'ESTIVAL P (NATALIE)'
  },
  {
    id_prestatario =>21298,
    nombre_comercial => 'ESTIVAL PARK'
  },
  {
    id_prestatario =>46129,
    nombre_comercial => 'HOTEL ESTIVAL PARK CLUB'
  },
  {
    id_prestatario =>21440,
    nombre_comercial => 'GOLDEN DONAIRE BEACH'
  },
  {
    id_prestatario =>21490,
    nombre_comercial => 'GRAN HOTEL LA HACIENDA'
  },
  {
    id_prestatario =>83068,
    nombre_comercial => 'GRAN PALAS'
  },
  {
    id_prestatario =>82761,
    nombre_comercial => 'GRAN HOTEL HACIENDA'
  },
  {
    id_prestatario =>71419,
    nombre_comercial => 'LOS JUNCOS'
  },
  {
    id_prestatario =>22292,
    nombre_comercial => 'MARE INTERNUM ()'
  },
  {
    id_prestatario =>22798,
    nombre_comercial => 'PALAS PINEDA'
  },
  {
    id_prestatario =>71732,
    nombre_comercial => 'Punta Prima'
  },
  {
    id_prestatario =>83130,
    nombre_comercial => 'SAN FRANCISCO APTOS.'
  },
  {
    id_prestatario =>23356,
    nombre_comercial => 'SOL COSTA DAURADA'
  },
  {
    id_prestatario =>64503,
    nombre_comercial => 'TERRAMARINA'
  },
  {
    id_prestatario =>20781,
    nombre_comercial => 'CARABELA'
  },
  {
    id_prestatario =>45675,
    nombre_comercial => 'TURQUESA'
  });
    
    my @objects;
    push @objects, new ClubSpain::XML::Terramar::Hotel($_)
        foreach (@expect);
      
    return \@objects;    
}
