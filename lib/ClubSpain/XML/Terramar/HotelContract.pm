package ClubSpain::XML::Terramar::HotelContract;

use Moose;

has 'id_articulo'     => ( is => 'rw', required => 1 );
has 'prestatario'     => ( is => 'rw', required => 1 );
has 'nombre_articulo' => ( is => 'rw', required => 1 );

has 'ocupacion' => ( is => 'rw', isa => 'ArrayRef' );
has 'rango'     => ( is => 'rw', isa => 'ArrayRef' );


package ClubSpain::XML::Terramar::HotelContract::Ocupacion;

use Moose;

has 'min_adultos' => ( is => 'rw', required => 1 );
has 'max_adultos' => ( is => 'rw', required => 1 );
has 'max_ninos'   => ( is => 'rw', required => 1 );
has 'min_pax'     => ( is => 'rw', required => 1 );
has 'max_pax'     => ( is => 'rw', required => 1 );

package ClubSpain::XML::Terramar::HotelContract::Rango;

use Moose;

has 'fecha_desde' => ( is => 'rw', required => 1 );
has 'fecha_hasta' => ( is => 'rw', required => 1 );

has 'precio'     => ( is => 'rw', isa => 'ArrayRef' );
has 'suplemento' => ( is => 'rw', isa => 'ArrayRef' );
has 'oferta'     => ( is => 'rw', isa => 'ArrayRef' );


package ClubSpain::XML::Terramar::HotelContract::Precio;

use Moose;

has 'con_suplemento_de_regimen'  => ( is => 'rw', required => 1 );
has 'importe'     => ( is => 'rw', required => 1 );
has 'importe_por' => ( is => 'rw', required => 1 );

package ClubSpain::XML::Terramar::HotelContract::Suplemento;

use Moose;

has 'id_suplemento' => ( is => 'rw', required => 1 );
has 'fecha_desde'   => ( is => 'rw', required => 1 );
has 'fecha_hasta'   => ( is => 'rw', required => 1 );
has 'pvp'           => ( is => 'rw', required => 1 );
has 'porcentaje'    => ( is => 'rw', required => 1 );
has 'id_clase'      => ( is => 'rw', required => 1 );
has 'nombre_clase'  => ( is => 'rw', required => 1 );
has 'referencia_pb' => ( is => 'rw', required => 1 );
has 'obligatorio'   => ( is => 'rw', required => 1 );
has 'importe_por'   => ( is => 'rw', required => 1 );
has 'rango_fechas'  => ( is => 'rw', required => 1 );
has 'suplemento'    => ( is => 'rw', required => 1 );

package ClubSpain::XML::Terramar::HotelContract::Oferta;

use Moose;

has 'id_oferta'                 => ( is => 'rw', required => 1 );
has 'tipo_oferta'               => ( is => 'rw', required => 1 );
has 'clase_oferta'              => ( is => 'rw', required => 1 );
has 'compra_desde'              => ( is => 'rw', required => 1 );
has 'compra_hasta'              => ( is => 'rw', required => 1 );
has 'entrada_desde'             => ( is => 'rw', required => 1 );
has 'entrada_hasta'             => ( is => 'rw', required => 1 );
has 'estancia_minima'           => ( is => 'rw', required => 1 );
has 'descripcion'               => ( is => 'rw', required => 1 );
has 'dias_entre_compra_entrada' => ( is => 'rw', required => 1 );
has 'oferta'                    => ( is => 'rw', required => 1 );

1;

=head

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

=cut
