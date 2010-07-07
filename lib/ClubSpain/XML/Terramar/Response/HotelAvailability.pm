package ClubSpain::XML::Terramar::Response::HotelAvailability;

use strict;
use warnings;

use XML::LibXML;
use ClubSpain::XML::Terramar::HotelAvailability;

sub parse {
    my ($self, $xml_sting) = @_;

    my $dom  = XML::LibXML->load_xml( string => $xml_sting );
    my $root   = $dom->getDocumentElement();
    my $xpath  = new XML::LibXML::XPathExpression('/integracion/intervalo');
    my $xpath_fecha_desde    = new XML::LibXML::XPathExpression('@fecha_desde');
    my $xpath_fecha_hasta    = new XML::LibXML::XPathExpression('@fecha_hasta');
    my $xpath_disponibilidad = new XML::LibXML::XPathExpression('@disponibilidad');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $object = ClubSpain::XML::Terramar::HotelAvailability->new({
            fecha_hasta    => $node->findvalue($xpath_fecha_hasta),
            fecha_desde    => $node->findvalue($xpath_fecha_desde),
            disponibilidad => $node->findvalue($xpath_disponibilidad),
        });

        push @res, $object;
    }

    return \@res;    
}

1;
