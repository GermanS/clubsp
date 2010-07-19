package ClubSpain::XML::Terramar::Response::HotelInfo;

use strict;
use warnings;

use XML::LibXML;
use ClubSpain::XML::Terramar::HotelInfo;

sub parse {
    my ($self, $xml_sting) = @_;

    my $dom = XML::LibXML->load_xml( string => $xml_sting );
    my $root = $dom->getDocumentElement();

    my $xpath                   = new XML::LibXML::XPathExpression('/integracion');
    my $xpath_nif               = new XML::LibXML::XPathExpression('nif');
    my $xpath_nombre_comercial  = new XML::LibXML::XPathExpression('nombre_comercial');
    my $xpath_description       = new XML::LibXML::XPathExpression('descripcion');
    my $xpath_direccion         = new XML::LibXML::XPathExpression('direccion');
    my $xpath_poblacion         = new XML::LibXML::XPathExpression('poblacion');
    my $xpath_provincia         = new XML::LibXML::XPathExpression('provincia');
    my $xpath_telefono          = new XML::LibXML::XPathExpression('telefono');
    my $xpath_fax               = new XML::LibXML::XPathExpression('fax');
    my $xpath_email             = new XML::LibXML::XPathExpression('email');
    my $xpath_url               = new XML::LibXML::XPathExpression('url');
    my $xpath_categoria         = new XML::LibXML::XPathExpression('categoria');
    my $xpath_linea_bono_1      = new XML::LibXML::XPathExpression('linea_bono_1');
    my $xpath_linea_bono_2      = new XML::LibXML::XPathExpression('linea_bono_2');
    my $xpath_linea_bono_3      = new XML::LibXML::XPathExpression('linea_bono_3');
    my $xpath_articulos_asociados = new XML::LibXML::XPathExpression('articulos_asociados');
    my $xpath_longitud          = new XML::LibXML::XPathExpression('longitud');
    my $xpath_latitud           = new XML::LibXML::XPathExpression('latitud');
    my $xpath_codigo_postal     = new XML::LibXML::XPathExpression('codigo_postal');


    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $info = ClubSpain::XML::Terramar::HotelInfo->new({
            nif                 => $node->findvalue($xpath_nif),
            nombre_comercial    => $node->findvalue($xpath_nombre_comercial),
            descripcion         => $node->findvalue($xpath_description),
            direccion           => $node->findvalue($xpath_direccion),
            poblacion           => $node->findvalue($xpath_poblacion),
            provincia           => $node->findvalue($xpath_provincia),
            telefono            => $node->findvalue($xpath_telefono),
            fax                 => $node->findvalue($xpath_fax),
            email               => $node->findvalue($xpath_email),
            url                 => $node->findvalue($xpath_url),
            categoria           => $node->findvalue($xpath_categoria),
            linea_bono_1        => $node->findvalue($xpath_linea_bono_1),
            linea_bono_2        => $node->findvalue($xpath_linea_bono_2),
            linea_bono_3        => $node->findvalue($xpath_linea_bono_3),
            articulos_asociados => $node->findvalue($xpath_articulos_asociados),
            longitud            => $node->findvalue($xpath_longitud),
            latitud             => $node->findvalue($xpath_latitud),
            codigo_postal       => $node->findvalue($xpath_codigo_postal),
            
            imagen              => $self->__parse_image($node),            
            caracteristica      => $self->__parse_caracteristica($node),
        });

        push @res, $info;
    }

    return \@res;
}

sub __parse_image {
    my ($self, $root) = @_;
    
    my $xpath = new XML::LibXML::XPathExpression('imagenes/imagen');
    
    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $object = ClubSpain::XML::Terramar::HotelInfo::Image->new({
            name => $node->textContent(),
        });
        
        push @res, $object;
    }

    return \@res;    
}

sub __parse_caracteristica {
    my ($self, $root) = @_;
    
    my $xpath = new XML::LibXML::XPathExpression('caracteristicas/caracteristica');
    my $xpath_caracteristica_categoria
       = new XML::LibXML::XPathExpression('@categoria');
    my $xpath_caracteristica_subcategoria
       = new XML::LibXML::XPathExpression('@subcategoria');
    my $xpath_caracteristica_nombre
       = new XML::LibXML::XPathExpression('@nombre');
    my $xpath_caracteristica_valor
       = new XML::LibXML::XPathExpression('@valor');
    my $xpath_caracteristica_id_caracteristica
       = new XML::LibXML::XPathExpression('@id_caracteristica');
    my $xpath_caracteristica_id_subcategoria
       = new XML::LibXML::XPathExpression('@id_subcategoria');    
    
    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $object = ClubSpain::XML::Terramar::HotelInfo::Caracteristica->new({
            categoria         => $node->findvalue($xpath_caracteristica_categoria),
            subcategoria      => $node->findvalue($xpath_caracteristica_subcategoria),
            nombre            => $node->findvalue($xpath_caracteristica_nombre),
            valor             => $node->findvalue($xpath_caracteristica_valor),
            id_caracteristica => $node->findvalue($xpath_caracteristica_id_caracteristica),
            id_subcategoria   => $node->findvalue($xpath_caracteristica_id_subcategoria),
        });
        
        push @res, $object;
    }

    return \@res;    
}

1;
