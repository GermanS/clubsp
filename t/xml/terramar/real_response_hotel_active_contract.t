use Test::More tests => 3;

use strict;
use warnings;

use File::Slurp;

use_ok('ClubSpain::XML::Terramar::HotelActiveContract');
use_ok('ClubSpain::XML::Terramar::Response::HotelActiveContract');

my $xml = read_file('t/var/terramar/response_hotel_active_contract.xml');
my $result = ClubSpain::XML::Terramar::Response::HotelActiveContract->parse($xml);

is_deeply($result, &expected(), 'compare objects');

sub expected {
    my @expect = ({
    id => "3447",
    nombre => "Junior Suite",
    id_tipo_articulo_clase =>2,
    id_tipo_articulo_superclase =>1,
    id_zona_pais =>1,
    id_zona => 1323,
  },
  {
    id => "9143",
    nombre => "Junior Suite",
    id_tipo_articulo_clase =>2,
    id_tipo_articulo_superclase =>1,
    id_zona_pais =>1,
    id_zona => 1323,
  },
  {
    id => "3444",
    nombre => "De Luxe Room",
    id_tipo_articulo_clase =>2,
    id_tipo_articulo_superclase =>1,
    id_zona_pais =>1,
    id_zona => 1323,
  },
  {
    id => "8691",
    nombre => "De Luxe Room",
    id_tipo_articulo_clase =>2,
    id_tipo_articulo_superclase =>1,
    id_zona_pais =>1,
    id_zona => 1323,
  },
  {
    id => "9142",
    nombre => "De Luxe Room",
    id_tipo_articulo_clase =>2,
    id_tipo_articulo_superclase =>1,
    id_zona_pais =>1,
    id_zona => 1323,
  },
  {
    id => "3448",
    nombre => "Suite Privilege",
    id_tipo_articulo_clase =>2,
    id_tipo_articulo_superclase =>1,
    id_zona_pais =>1,
    id_zona => 1323,
  },
  {
    id => "9144",
    nombre => "Suite Privilege",
    id_tipo_articulo_clase =>2,
    id_tipo_articulo_superclase =>1,
    id_zona_pais =>1,
    id_zona => 1323,
  });
    my @objects;
    push @objects, new ClubSpain::XML::Terramar::HotelActiveContract($_)
        foreach (@expect);
      
    return \@objects;        
}
