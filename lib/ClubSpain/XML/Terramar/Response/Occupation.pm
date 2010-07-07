package ClubSpain::XML::Terramar::Response::Occupation;

use strict;
use warnings;

use XML::LibXML;
use ClubSpain::XML::Terramar::Occupation;

sub parse {
    my ($self, $xml_sting) = @_;

    my $dom  = XML::LibXML->load_xml( string => $xml_sting );
    my $root   = $dom->getDocumentElement();
    my $xpath               = new XML::LibXML::XPathExpression('/integracion');
    my $xpath_adultos_max   = new XML::LibXML::XPathExpression('adultos_max');
    my $xpath_adultos_min   = new XML::LibXML::XPathExpression('adultos_min');
    my $xpath_ninos_max     = new XML::LibXML::XPathExpression('ninos_max');
    my $xpath_pax_max       = new XML::LibXML::XPathExpression('pax_max');
    my $xpath_edad_nino_max = new XML::LibXML::XPathExpression('edad_nino_max');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $object = ClubSpain::XML::Terramar::Occupation->new({
            adultos_max   => $node->findvalue($xpath_adultos_max),
            adultos_min   => $node->findvalue($xpath_adultos_min),
            ninos_max     => $node->findvalue($xpath_ninos_max),
            pax_max       => $node->findvalue($xpath_pax_max),
            edad_nino_max => $node->findvalue($xpath_edad_nino_max)
        });

        push @res, $object;
    }

    return \@res;    
}

1;
