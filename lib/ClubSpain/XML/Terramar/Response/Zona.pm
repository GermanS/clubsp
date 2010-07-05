package ClubSpain::XML::Terramar::Response::Zona;

use strict;
use warnings;

use XML::LibXML;
use ClubSpain::XML::Terramar::Zona;

sub parse {
    my ($self, $xml_sting) = @_;
    
    my $dom = XML::LibXML->load_xml( string => $xml_sting );
    my $root = $dom->getDocumentElement();
    
    my $xpath          = new XML::LibXML::XPathExpression('/integracion/zona');    
    my $xpath_id_zona  = new XML::LibXML::XPathExpression('id_zona');
    my $xpath_nombre   = new XML::LibXML::XPathExpression('nombre');
    
    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {        
        my $object = ClubSpain::XML::Terramar::Zona->new({
            id_zona   => $node->findvalue($xpath_id_zona),
            nombre    => $node->findvalue($xpath_nombre),
        });
       
        push @res, $object;
    }
    
    return \@res;
}

1;
