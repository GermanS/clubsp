package ClubSpain::XML::Terramar::Response::Province;

use strict;
use warnings;

use XML::LibXML;
use ClubSpain::XML::Terramar::Province;

sub parse {
    my ($self, $xml_sting) = @_;
    
    my $dom = XML::LibXML->load_xml( string => $xml_sting );
    my $root = $dom->getDocumentElement();
    
    my $xpath            = new XML::LibXML::XPathExpression('/integracion');    
    my $xpath_provincia  = new XML::LibXML::XPathExpression('provincia');
        
    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {        
        my $object = ClubSpain::XML::Terramar::Province->new({
            provincia => $node->findvalue($xpath_provincia)
        });
       
        push @res, $object;
    }
    
    return \@res;
}

1;
