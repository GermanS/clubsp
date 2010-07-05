package ClubSpain::XML::Terramar::Response::ProductType;

use strict;
use warnings;

use XML::LibXML;
use ClubSpain::XML::Terramar::ProductType;

sub parse {
    my ( $self, $xml_sting ) = @_;
    
    my $dom = XML::LibXML->load_xml( string => $xml_sting );
    my $root = $dom->getDocumentElement();
    
    my $xpath                         = new XML::LibXML::XPathExpression('/integracion/clase');    
    my $xpath_id                      = new XML::LibXML::XPathExpression('id_tipo_articulo_clase');
    my $xpath_id_tipo_menu            = new XML::LibXML::XPathExpression('id_tipo_menu');
    my $xpath_articulo_clase          = new XML::LibXML::XPathExpression('articulo_clase');      
    my $xpath_busqueda_predeterminada = new XML::LibXML::XPathExpression('busqueda_predeterminada');  
    my $xpath_zona_predeterminada     = new XML::LibXML::XPathExpression('zona_predeterminada');  
    my $xpath_regimen_predeterminado  = new XML::LibXML::XPathExpression('regimen_predeterminado');  
    my $xpath_orden                   = new XML::LibXML::XPathExpression('orden');  
    my $xpath_visible_minorista       = new XML::LibXML::XPathExpression('visible_minorista');      
    my $xpath_filtros_busqueda_diferencia_dias = new XML::LibXML::XPathExpression('filtros_busqueda_diferencia_dias');   
    

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {        
        my $obj = ClubSpain::XML::Terramar::ProductType->new({
            id_tipo_articulo_clase  => $node->findvalue($xpath_id),
            id_tipo_menu            => $node->findvalue($xpath_id_tipo_menu),
            articulo_clase          => $node->findvalue($xpath_articulo_clase),
            busqueda_predeterminada => $node->findvalue($xpath_busqueda_predeterminada),
            zona_predeterminada     => $node->findvalue($xpath_zona_predeterminada),
            regimen_predeterminado  => $node->findvalue($xpath_regimen_predeterminado),
            orden                   => $node->findvalue($xpath_orden),
            visible_minorista       => $node->findvalue($xpath_visible_minorista),
            filtros_busqueda_diferencia_dias => $node->findvalue($xpath_filtros_busqueda_diferencia_dias)
        });
       
        push @res, $obj;
    }
    
    return \@res;    
}

1;
