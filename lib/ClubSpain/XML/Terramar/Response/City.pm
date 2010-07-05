package ClubSpain::XML::Terramar::Response::City;

use strict;
use warnings;

use XML::LibXML;
use ClubSpain::XML::Terramar::City;

sub parse {
    my ($self, $xml_sting) = @_;

    my $dom  = XML::LibXML->load_xml( string => $xml_sting );
    my $root   = $dom->getDocumentElement();
    my $xpath  = new XML::LibXML::XPathExpression('/integracion/poblacion');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $object = ClubSpain::XML::Terramar::City->new({
            poblacion => $node->textContent()
        });

        push @res, $object;
    }

    return \@res;
}


1;
