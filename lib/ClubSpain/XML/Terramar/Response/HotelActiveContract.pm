package ClubSpain::XML::Terramar::Response::HotelActiveContract;

use strict;
use warnings;

use XML::LibXML;
use ClubSpain::XML::Terramar::HotelActiveContract;

sub parse {
    my ($self, $xml_sting) = @_;

    my $dom  = XML::LibXML->load_xml( string => $xml_sting );
    my $root = $dom->getDocumentElement();

    my $xpath                               = new XML::LibXML::XPathExpression('/integracion/articulo');
    my $xpath_id                            = new XML::LibXML::XPathExpression('id');
    my $xpath_nombre                        = new XML::LibXML::XPathExpression('nombre');
    my $xpath_id_tipo_articulo_clase        = new XML::LibXML::XPathExpression('id_tipo_articulo_clase');
    my $xpath_id_tipo_articulo_superclase   = new XML::LibXML::XPathExpression('id_tipo_articulo_superclase');
    my $xpath_id_zona_pais                  = new XML::LibXML::XPathExpression('id_zona_pais');
    my $xpath_id_zona                       = new XML::LibXML::XPathExpression('id_zona');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $object = ClubSpain::XML::Terramar::HotelActiveContract->new({
            id                          => $node->findvalue($xpath_id),
            nombre                      => $node->findvalue($xpath_nombre),
            id_tipo_articulo_clase      => $node->findvalue($xpath_id_tipo_articulo_clase),
            id_tipo_articulo_superclase => $node->findvalue($xpath_id_tipo_articulo_superclase),
            id_zona_pais                => $node->findvalue($xpath_id_zona_pais),
            id_zona                     => $node->findvalue($xpath_id_zona),
        });

        push @res, $object;
    }

    return \@res;
}

1;
