package ClubSpain::XML::Terramar::Response::HotelContract;

use strict;
use warnings;

use XML::LibXML;
use ClubSpain::XML::Terramar::HotelContract;

sub parse {
    my ($self, $xml_sting) = @_;

    my $dom = XML::LibXML->load_xml( string => $xml_sting );
    my $root = $dom->getDocumentElement();

    my $xpath                 = new XML::LibXML::XPathExpression('/integracion');
    my $xpath_id_articulo     = new XML::LibXML::XPathExpression('@id_articulo');
    my $xpath_prestatario     = new XML::LibXML::XPathExpression('@prestatario');
    my $xpath_nombre_articulo = new XML::LibXML::XPathExpression('@nombre_articulo');


    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $object = ClubSpain::XML::Terramar::HotelContract->new({
            id_articulo     => $node->findvalue($xpath_id_articulo),
            prestatario     => $node->findvalue($xpath_prestatario),
            nombre_articulo => $node->findvalue($xpath_nombre_articulo),
            ocupacion       => $self->__parse_ocupacion($node),
            rango           => $self->__parse_rango($node),
        });

        push @res, $object;
    }

    return \@res;
}

sub __parse_ocupacion {
    my ($self, $root) = @_;

    my $xpath             = new XML::LibXML::XPathExpression('ocupacion');
    my $xpath_min_adultos = new XML::LibXML::XPathExpression('@min_adultos');
    my $xpath_max_adultos = new XML::LibXML::XPathExpression('@max_adultos');
    my $xpath_max_ninos   = new XML::LibXML::XPathExpression('@max_ninos');
    my $xpath_min_pax     = new XML::LibXML::XPathExpression('@min_pax');
    my $xpath_max_pax     = new XML::LibXML::XPathExpression('@max_pax');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
         my $object = ClubSpain::XML::Terramar::HotelContract::Ocupacion->new({
            min_adultos => $node->findvalue($xpath_min_adultos),
            max_adultos => $node->findvalue($xpath_max_adultos),
            max_ninos   => $node->findvalue($xpath_max_ninos),
            min_pax     => $node->findvalue($xpath_min_pax),
            max_pax     => $node->findvalue($xpath_max_pax)
        });

        push @res, $object;
    }

    return \@res;
}

sub __parse_rango {
    my ($self, $root) = @_;

    my $xpath             = new XML::LibXML::XPathExpression('rango');
    my $xpath_fecha_desde = new XML::LibXML::XPathExpression('@fecha_desde');
    my $xpath_fecha_hasta = new XML::LibXML::XPathExpression('@fecha_hasta');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $object = ClubSpain::XML::Terramar::HotelContract::Rango->new({
            fecha_desde => $node->findvalue($xpath_fecha_desde),
            fecha_hasta => $node->findvalue($xpath_fecha_hasta),

            precio     => $self->__parse_precio($node),
            suplemento => $self->__parse_suplemento($node),
            oferta     => $self->__parse_oferta($node),
        });

        push @res, $object;
    }

    return \@res;
}

sub __parse_precio {
    my ($self, $root) = @_;

    my $xpath             = new XML::LibXML::XPathExpression('precios/precio');
    my $xpath_regimen     = new XML::LibXML::XPathExpression('@con_suplemento_de_regimen');
    my $xpath_importe     = new XML::LibXML::XPathExpression('@importe');
    my $xpath_importe_por = new XML::LibXML::XPathExpression('@importe_por');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $object = ClubSpain::XML::Terramar::HotelContract::Precio->new({
            con_suplemento_de_regimen => $node->findvalue($xpath_regimen),
            importe     => $node->findvalue($xpath_importe),
            importe_por => $node->findvalue($xpath_importe_por)
        });

        push @res, $object;
    }

    return \@res;
}

sub __parse_suplemento {
    my ($self, $root) = @_;

    my $xpath               = new XML::LibXML::XPathExpression('suplementos/suplemento');
    my $xpath_id_suplemento = new XML::LibXML::XPathExpression('@id_suplemento');
    my $xpath_fecha_desde   = new XML::LibXML::XPathExpression('@fecha_desde');
    my $xpath_fecha_hasta   = new XML::LibXML::XPathExpression('@fecha_hasta');
    my $xpath_pvp           = new XML::LibXML::XPathExpression('@pvp');
    my $xpath_porcentaje    = new XML::LibXML::XPathExpression('@porcentaje');
    my $xpath_id_clase      = new XML::LibXML::XPathExpression('@id_clase');
    my $xpath_nombre_clase  = new XML::LibXML::XPathExpression('@nombre_clase');
    my $xpath_referencia_pb = new XML::LibXML::XPathExpression('@referencia_pb');
    my $xpath_obligatorio   = new XML::LibXML::XPathExpression('@obligatorio');
    my $xpath_importe_por   = new XML::LibXML::XPathExpression('@importe_por');
    my $xpath_rango_fechas  = new XML::LibXML::XPathExpression('@rango_fechas');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $object = ClubSpain::XML::Terramar::HotelContract::Suplemento->new({
            id_suplemento => $node->findvalue($xpath_id_suplemento),
            fecha_desde   => $node->findvalue($xpath_fecha_desde),
            fecha_hasta   => $node->findvalue($xpath_fecha_hasta),
            pvp           => $node->findvalue($xpath_pvp),
            porcentaje    => $node->findvalue($xpath_porcentaje),
            id_clase      => $node->findvalue($xpath_id_clase),
            nombre_clase  => $node->findvalue($xpath_nombre_clase),
            referencia_pb => $node->findvalue($xpath_referencia_pb),
            obligatorio   => $node->findvalue($xpath_obligatorio),
            importe_por   => $node->findvalue($xpath_importe_por),
            rango_fechas  => $node->findvalue($xpath_rango_fechas),
            suplemento    => $node->textContent()
        });

        push @res, $object;
    }

    return \@res;
}

sub __parse_oferta {
    my ($self, $root) = @_;

    my $xpath = new XML::LibXML::XPathExpression('ofertas/oferta');
    my $xpath_id_oferta     = new XML::LibXML::XPathExpression('@id_oferta');
    my $xpath_tipo_oferta   = new XML::LibXML::XPathExpression('@tipo_oferta');
    my $xpath_clase_oferta  = new XML::LibXML::XPathExpression('@clase_oferta');
    my $xpath_compra_desde  = new XML::LibXML::XPathExpression('@compra_desde');
    my $xpath_compra_hasta  = new XML::LibXML::XPathExpression('@compra_hasta');
    my $xpath_entrada_desde = new XML::LibXML::XPathExpression('@entrada_desde');
    my $xpath_entrada_hasta = new XML::LibXML::XPathExpression('@entrada_hasta');
    my $xpath_estancia_minima= new XML::LibXML::XPathExpression('@estancia_minima');
    my $xpath_descripcion   = new XML::LibXML::XPathExpression('@descripcion');
    my $xpath_dias_entre_compra_entrada
                            = new XML::LibXML::XPathExpression('@dias_entre_compra_entrada');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $object = ClubSpain::XML::Terramar::HotelContract::Oferta->new({
            id_oferta                 => $node->findvalue($xpath_id_oferta),
            tipo_oferta               => $node->findvalue($xpath_tipo_oferta),
            clase_oferta              => $node->findvalue($xpath_clase_oferta),
            compra_desde              => $node->findvalue($xpath_compra_desde),
            compra_hasta              => $node->findvalue($xpath_compra_hasta),
            entrada_desde             => $node->findvalue($xpath_entrada_desde),
            entrada_hasta             => $node->findvalue($xpath_entrada_hasta),
            estancia_minima           => $node->findvalue($xpath_estancia_minima),
            descripcion               => $node->findvalue($xpath_descripcion),
            dias_entre_compra_entrada => $node->findvalue($xpath_dias_entre_compra_entrada),
            oferta                    => $node->textContent(),
        });

        push @res, $object;
    }

    return \@res;
}

1;

__END__

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
