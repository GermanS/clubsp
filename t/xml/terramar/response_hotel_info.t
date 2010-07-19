use Test::More tests => 3;

use strict;
use warnings;

use utf8;

use_ok('ClubSpain::XML::Terramar::Response::HotelInfo');

my $response =<<"";
<integracion accion="ficha_tecnica">
  <nif/>
  <nombre_comercial>Nuevo Islantilla Park</nombre_comercial>
  <descripcion>
        Confortable hotel de atractivo estilo arquitectónico típicamente andaluz que cuenta con 300 habitaciones y
        101 apartamentos repartidos en dos edificios. Dispone de un amplio lobby, recepción con cambio de divisas,
        alquiler de coches y de bicicletas, restaurante con Show Cooking, restaurante de especialidades, cafetería,
        boutique y piscina cubierta.
  </descripcion>
  <imagenes>
    <imagen>http://www.orbisbooking.com/dominios/tmt/fotos/22798_1.jpg</imagen>
    <imagen>http://www.orbisbooking.com/dominios/tmt/fotos/22798_2.jpg</imagen>
  </imagenes>
  <direccion>direccion</direccion>
  <poblacion>poblacion</poblacion>
  <provincia>provincia</provincia>
  <codigo_postal>codig</codigo_postal>
  <telefono>telefono</telefono>
  <fax>fax</fax>
  <email>mail</email>
  <url>web</url>
  <categoria>1</categoria>
  <longitud>0.000000</longitud>
  <latitud>0.000000</latitud>
  <caracteristicas>
    <caracteristica categoria="" subcategoria="" nombre="Satellite TV" id_caracteristica="1" id_subcategoria="2" valor="Si"/>
    <caracteristica categoria="" subcategoria="" nombre="Outdoor pool" id_caracteristica="2" id_subcategoria="1" valor="Si"/>
    <caracteristica categoria="" subcategoria="" nombre="Disabled facilities only" id_caracteristica="3" id_subcategoria="1" valor="Si"/>
    <caracteristica categoria="" subcategoria="" nombre="Restaurant" id_caracteristica="8" id_subcategoria="1" valor="Si"/>
  </caracteristicas>
  <linea_bono_1/>
  <linea_bono_2/>
  <linea_bono_3/>
  <articulos_asociados>12</articulos_asociados>
</integracion>

my $array = ClubSpain::XML::Terramar::Response::HotelInfo->parse($response);
is(scalar @$array, 1, 'count objects');

my @images = map new ClubSpain::XML::Terramar::HotelInfo::Image({ name => $_ }), 
    qw(http://www.orbisbooking.com/dominios/tmt/fotos/22798_1.jpg 
       http://www.orbisbooking.com/dominios/tmt/fotos/22798_2.jpg);

my @caracteristicas = map new ClubSpain::XML::Terramar::HotelInfo::Caracteristica($_),
({ categoria=>"", subcategoria=>"", nombre=>"Satellite TV", id_caracteristica=>"1", id_subcategoria=>"2", valor=>"Si" },
 { categoria=>"", subcategoria=>"", nombre=>"Outdoor pool", id_caracteristica=>"2", id_subcategoria=>"1", valor=>"Si" },
 { categoria=>"", subcategoria=>"", nombre=>"Disabled facilities only", id_caracteristica=>"3", id_subcategoria=>"1", valor=>"Si" },
 { categoria=>"", subcategoria=>"", nombre=>"Restaurant", id_caracteristica=>"8", id_subcategoria=>"1", valor=>"Si" });
 

my $info = ClubSpain::XML::Terramar::HotelInfo->new({
    nif                 => '',
    nombre_comercial    => 'Nuevo Islantilla Park',
    descripcion         => '
        Confortable hotel de atractivo estilo arquitectónico típicamente andaluz que cuenta con 300 habitaciones y
        101 apartamentos repartidos en dos edificios. Dispone de un amplio lobby, recepción con cambio de divisas,
        alquiler de coches y de bicicletas, restaurante con Show Cooking, restaurante de especialidades, cafetería,
        boutique y piscina cubierta.
  ',
    direccion           => 'direccion',
    poblacion           => 'poblacion',
    provincia           => 'provincia',
    telefono            => 'telefono',
    fax                 => 'fax',
    email               => 'mail',
    url                 => 'web',
    categoria           => 1,
    linea_bono_1        => '',
    linea_bono_2        => '',
    linea_bono_3        => '',
    articulos_asociados => 12,
    longitud            => '0.000000',
    latitud             => '0.000000',
    codigo_postal       => 'codig',
    imagen              => \@images,
    caracteristica      => \@caracteristicas
});

is_deeply($array, [$info], 'returned hotrl info');
