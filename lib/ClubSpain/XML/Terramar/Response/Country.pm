package ClubSpain::XML::Terramar::Response::Country;

use strict;
use warnings;

use XML::LibXML;
use ClubSpain::XML::Terramar::Country;

sub parse {
    my ($self, $xml_sting) = @_;
    
    my $dom = XML::LibXML->load_xml( string => $xml_sting );
    my $root = $dom->getDocumentElement();
    
    my $xpath               = new XML::LibXML::XPathExpression('/integracion/pais');    
    my $xpath_id_zona_pais  = new XML::LibXML::XPathExpression('id_zona_pais');
    my $xpath_nombre        = new XML::LibXML::XPathExpression('nombre');
    
    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {        
        my $object = ClubSpain::XML::Terramar::Country->new({
            id_zona_pais => $node->findvalue($xpath_id_zona_pais),
            nombre       => $node->findvalue($xpath_nombre),
        });
       
        push @res, $object;
    }
    
    return \@res;
}

1;
