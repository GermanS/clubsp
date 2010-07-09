use Test::More tests => 35;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::HotelContract');

my $suplemento = ClubSpain::XML::Terramar::HotelContract::Suplemento->new({
    id_suplemento => 'id_suplemento',
    fecha_desde   => 'fecha_desde',
    fecha_hasta   => 'fecha_hasta',
    pvp           => 'pvp',
    porcentaje    => 'porcentaje',
    id_clase      => 'id_clase',
    nombre_clase  => 'nombre_clase',
    referencia_pb => 'referencia_pb',
    obligatorio   => 'obligatorio',
    importe_por   => 'importe_por',
    rango_fechas  => 'rango_fechas',
    suplemento    => 'suplemento',
});

isa_ok($suplemento, 'ClubSpain::XML::Terramar::HotelContract::Suplemento');
is($suplemento->id_suplemento, 'id_suplemento', 'got id_suplemento');
is($suplemento->fecha_desde, 'fecha_desde', 'got fecha_desde');
is($suplemento->fecha_hasta, 'fecha_hasta', 'got fecha_hasta');
is($suplemento->pvp, 'pvp', 'got pvp');
is($suplemento->porcentaje, 'porcentaje', 'got porcentaje');
is($suplemento->id_clase, 'id_clase', 'got id_clase');
is($suplemento->nombre_clase, 'nombre_clase', 'got nombre_clase');
is($suplemento->referencia_pb, 'referencia_pb', 'got referencia_pb');
is($suplemento->obligatorio, 'obligatorio', 'got obligatorio');
is($suplemento->importe_por, 'importe_por', 'got importe_por');
is($suplemento->rango_fechas, 'rango_fechas', 'got rango_fechas');
is($suplemento->suplemento, 'suplemento', 'got suplemento');



my $precio = ClubSpain::XML::Terramar::HotelContract::Precio->new({
    regimen => 'regimen',
    importe => 'importe',
    importe_por => 'importe_por'
});

isa_ok($precio, 'ClubSpain::XML::Terramar::HotelContract::Precio');
is($precio->regimen, 'regimen', 'got regimen');
is($precio->importe, 'importe', 'got importe');
is($precio->importe_por, 'importe_por', 'got importe_por');


my $rango = ClubSpain::XML::Terramar::HotelContract::Rango->new({
    fecha_desde => 'fecha_desde',
    fecha_hasta => 'fecha_hasta',
    
    precio => $precio,
    suplemento => $suplemento,
});

isa_ok($rango, 'ClubSpain::XML::Terramar::HotelContract::Rango');
is($rango->fecha_desde, 'fecha_desde', 'got fecha desde');
is($rango->fecha_hasta, 'fecha_hasta', 'got fecha_hasta');
is_deeply($rango->precio, $precio, 'got precio');
is_deeply($rango->suplemento, $suplemento, 'got suplemento');



my $ocupacion = ClubSpain::XML::Terramar::HotelContract::Ocupacion->new({
    min_adultos => 'min_adultos',
    max_adultos => 'max_adultos',
    max_ninos   => 'max_ninos',
    min_pax     => 'min_pax',
    max_pax     => 'max_pax',
});

isa_ok($ocupacion, 'ClubSpain::XML::Terramar::HotelContract::Ocupacion');
is($ocupacion->min_adultos, 'min_adultos', 'got min adultos');
is($ocupacion->max_adultos, 'max_adultos', 'got max adultos');
is($ocupacion->max_ninos, 'max_ninos', 'got max_ninos');
is($ocupacion->min_pax, 'min_pax', 'got min pax');
is($ocupacion->max_pax, 'max_pax', 'got max pax');



my $contract = ClubSpain::XML::Terramar::HotelContract->new({
    id_articulo     => 'id_articulo',
    prestatario     => 'prestatario',
    nombre_articulo => 'nombre_articulo',
    ocupacion       => $ocupacion,
    rango           => $rango,
});

isa_ok($contract, 'ClubSpain::XML::Terramar::HotelContract');
is($contract->id_articulo, 'id_articulo', 'got id_artuculo');
is($contract->prestatario, 'prestatario', 'got prestatario');
is($contract->nombre_articulo, 'nombre_articulo', 'got nombre_articulo');
is_deeply($contract->ocupacion, $ocupacion, 'got ocupacion');
is_deeply($contract->rango, $rango, 'got rango');
