use Test::More tests => 22;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::HotelInfo');

my $info = ClubSpain::XML::Terramar::HotelInfo->new({
    nif                 => 'nif',
    nombre_comercial    => 'nombre_comercial',
    descripcion         => 'Description',
    imagen              => [
        new ClubSpain::XML::Terramar::HotelInfo::Image({ name => 'xxx'}),
        new ClubSpain::XML::Terramar::HotelInfo::Image({ name => 'yyy'})
    ],
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
    caracteristica      => [
        new ClubSpain::XML::Terramar::HotelInfo::Caracteristica({
            categoria => 'categoria',
            subcategoria => 'subcategoria',
            nombre => 'nombre',
            valor => 'valor',
            id_caracteristica => 'id_caracteristica',
            id_subcategoria => 'id_subcategoria',
        }),
        new ClubSpain::XML::Terramar::HotelInfo::Caracteristica({
            categoria => 'categoria1',
            subcategoria => 'subcategoria1',
            nombre => 'nombre1',
            valor => 'valor1',
            id_caracteristica => 'id_caracteristica1',
            id_subcategoria => 'id_subcategoria1',
        }),        
    ]
});


isa_ok($info, 'ClubSpain::XML::Terramar::HotelInfo');
is($info->nif, 'nif', 'got nif');
is($info->nombre_comercial, 'nombre_comercial', 'got nombre_comercial');
is($info->descripcion, 'Description', 'got Description');
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
is_deeply($info->imagen, [
    new ClubSpain::XML::Terramar::HotelInfo::Image({ name => 'xxx'}),
    new ClubSpain::XML::Terramar::HotelInfo::Image({ name => 'yyy'})
], 'got images');
is_deeply($info->caracteristica, [
        new ClubSpain::XML::Terramar::HotelInfo::Caracteristica({
            categoria => 'categoria',
            subcategoria => 'subcategoria',
            nombre => 'nombre',
            valor => 'valor',
            id_caracteristica => 'id_caracteristica',
            id_subcategoria => 'id_subcategoria',
        }),
        new ClubSpain::XML::Terramar::HotelInfo::Caracteristica({
            categoria => 'categoria1',
            subcategoria => 'subcategoria1',
            nombre => 'nombre1',
            valor => 'valor1',
            id_caracteristica => 'id_caracteristica1',
            id_subcategoria => 'id_subcategoria1',
        })
], 'got caracteristicas');
