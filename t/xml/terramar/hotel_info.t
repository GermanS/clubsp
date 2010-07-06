use Test::More tests => 27;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::HotelInfo');

my $info = ClubSpain::XML::Terramar::HotelInfo->new({
    nif                 => 'nif',
    nombre_comercial    => 'nombre_comercial',
    description         => 'Description',
    imagen              => 'imagen',
    direccion           => 'direccion',
    poblacion           => 'poblacion',
    provincia           => 'provincia',
    telefono            => 'telefono',
    fax                 => 'fax',
    email               => 'email',
    url                 => 'url',
    categoria           => 'categoria',
    linea_bono_1        => 'linea_bono_1',
    linea_bono_2        => 'linea_bono_2',
    linea_bono_3        => 'linea_bono_3',
    articulos_asociados => 'articulos_asociados',
    longitud            => 'longitud',
    latitud             => 'latitud',
    codigo_postal       => 'codigo_postal',
    caracteristica_categoria         => 'caracteristica_categoria',
    caracteristica_subcategoria      => 'caracteristica_subcategoria',
    caracteristica_nombre            => 'caracteristica_nombre',
    caracteristica_valor             => 'caracteristica_valor',
    caracteristica_id_caracteristica => 'caracteristica_id_caracteristica',
    caracteristica_id_subcategoria   => 'caracteristica_id_subcategoria',
});


isa_ok($info, 'ClubSpain::XML::Terramar::HotelInfo');
is($info->nif, 'nif', 'got nif');
is($info->nombre_comercial, 'nombre_comercial', 'got nombre_comercial');
is($info->description, 'Description', 'got Description');
is($info->imagen, 'imagen', 'got imagen');
is($info->direccion, 'direccion', 'got direccion');
is($info->poblacion, 'poblacion', 'got poblacion');
is($info->provincia, 'provincia', 'got provincia');
is($info->telefono, 'telefono', 'got telefono');
is($info->fax, 'fax', 'got fax');
is($info->email, 'email', 'got email');
is($info->url, 'url', 'got url');
is($info->categoria, 'categoria', 'got categoria');
is($info->linea_bono_1, 'linea_bono_1', 'got linea_bono_1');
is($info->linea_bono_2, 'linea_bono_2', 'got linea_bono_2');
is($info->linea_bono_3, 'linea_bono_3', 'got linea_bono_3');
is($info->articulos_asociados, 'articulos_asociados', 'got articulos_asociados');
is($info->longitud, 'longitud', 'got longitud');
is($info->latitud, 'latitud', 'got latitud');
is($info->codigo_postal, 'codigo_postal', 'got codigo_postal');
is($info->caracteristica_categoria, 'caracteristica_categoria', 'got caracteristica_categoria');
is($info->caracteristica_subcategoria, 'caracteristica_subcategoria', 'got caracteristica_subcategoria');
is($info->caracteristica_nombre, 'caracteristica_nombre', 'got caracteristica_nombre');
is($info->caracteristica_valor, 'caracteristica_valor', 'got caracteristica_valor');
is($info->caracteristica_id_caracteristica, 'caracteristica_id_caracteristica', 'got caracteristica_id_caracteristica');
is($info->caracteristica_id_subcategoria, 'caracteristica_id_subcategoria', 'got caracteristica_id_subcategoria');
