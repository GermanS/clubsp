use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Response::HotelContract');

my $response =<<'';
<?xml version="1.0"?>
<integracion accion="informe_imprenta" id_articulo="848" prestatario="49" nombre_articulo="14 noches">
  <ocupacion min_adultos="1" max_adultos="3" max_ninos="3" min_pax="1" max_pax="4"/>
  <rango fecha_desde="2009-11-02" fecha_hasta="2009-11-08">
    <precios>
      <precio con_suplemento_de_regimen="PC" importe="479.00" importe_por="pax"/>
    </precios>
    <suplementos>
      <suplemento id_suplemento="1086"
                  fecha_desde="2009-11-02"
                  fecha_hasta="2010-03-22"
                  pvp="210.00"
                  porcentaje="0.00"
                  id_clase="2"
                  nombre_clase="Extra pax"
                  referencia_pb="1"
                  obligatorio="0"
                  importe_por="pax"
                  rango_fechas="total">Individual</suplemento>
      <suplemento id_suplemento="1087"
                  fecha_desde="2009-11-02"
                  fecha_hasta="2010-03-22"
                  pvp="0.00"
                  porcentaje="0.00"
                  id_clase="4"
                  nombre_clase="Varios"
                  referencia_pb="1"
                  obligatorio="1"
                  importe_por="articulo"
                  rango_fechas="total">BONIFICACION 100 EUROS POR PASAJERO</suplemento>
      <suplemento id_suplemento="1088"
                  fecha_desde="2009-11-02"
                  fecha_hasta="2010-03-22"
                  pvp="0.00"
                  porcentaje="0.00"
                  id_clase="2"
                  nombre_clase="Extra pax"
                  referencia_pb="1"
                  obligatorio="0"
                  importe_por="pax"
                  rango_fechas="total">Tercera persona</suplemento>
    </suplementos>
    <ofertas/>
  </rango>
</integracion>

my $array = ClubSpain::XML::Terramar::Response::HotelContract->parse($response);
is(scalar @$array, 1, 'count objects');

my $contract = ClubSpain::XML::Terramar::HotelContract->new({
    id_articulo     => 848,
    prestatario     => 49,
    nombre_articulo => '14 noches',
    ocupacion       => [
        ClubSpain::XML::Terramar::HotelContract::Ocupacion->new({
            min_adultos => 1,
            max_adultos => 3,
            max_ninos   => 3,
            min_pax     => 1,
            max_pax     => 4,
        })
    ],
    rango           => [
        ClubSpain::XML::Terramar::HotelContract::Rango->new({
            fecha_desde => '2009-11-02',
            fecha_hasta => '2009-11-08',
            precio      => [
                ClubSpain::XML::Terramar::HotelContract::Precio->new({
                    con_suplemento_de_regimen     => 'PC',
                    importe     => '479.00',
                    importe_por => 'pax'
                })
            ],
            suplemento  => [
                ClubSpain::XML::Terramar::HotelContract::Suplemento->new({
                    id_suplemento => 1086,
                    fecha_desde   => '2009-11-02',
                    fecha_hasta   => '2010-03-22',
                    pvp           => '210.00',
                    porcentaje    => '0.00',
                    id_clase      => '2',
                    nombre_clase  => 'Extra pax',
                    referencia_pb => '1',
                    obligatorio   => '0',
                    importe_por   => 'pax',
                    rango_fechas  => 'total',
                    suplemento    => 'Individual',
                }),
                ClubSpain::XML::Terramar::HotelContract::Suplemento->new({
                    id_suplemento => 1087,
                    fecha_desde   => '2009-11-02',
                    fecha_hasta   => '2010-03-22',
                    pvp           => '0.00',
                    porcentaje    => '0.00',
                    id_clase      => '4',
                    nombre_clase  => 'Varios',
                    referencia_pb => '1',
                    obligatorio   => '1',
                    importe_por   => 'articulo',
                    rango_fechas  => 'total',
                    suplemento    => 'BONIFICACION 100 EUROS POR PASAJERO',
                }),
                ClubSpain::XML::Terramar::HotelContract::Suplemento->new({
                    id_suplemento => 1088,
                    fecha_desde   => '2009-11-02',
                    fecha_hasta   => '2010-03-22',
                    pvp           => '0.00',
                    porcentaje    => '0.00',
                    id_clase      => '2',
                    nombre_clase  => 'Extra pax',
                    referencia_pb => '1',
                    obligatorio   => '0',
                    importe_por   => 'pax',
                    rango_fechas  => 'total',
                    suplemento    => 'Tercera persona',
                }),
            ]
        })
    ]
});

is_deeply($array, [$contract], 'returned contract');
