package ClubSpain::XML::Terramar::Response::Hotel;

use strict;
use warnings;

use XML::LibXML;
use ClubSpain::XML::Terramar::Hotel;

sub parse {
    my ($self, $xml_sting) = @_;

    my $dom = XML::LibXML->load_xml( string => $xml_sting );
    my $root = $dom->getDocumentElement();

    my $xpath                  = new XML::LibXML::XPathExpression('/integracion/prestatario');
    my $xpath_id_prestatario   = new XML::LibXML::XPathExpression('id_prestatario');
    my $xpath_nombre_comercial = new XML::LibXML::XPathExpression('nombre_comercial');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $lang = ClubSpain::XML::Terramar::Hotel->new({
            id_prestatario   => $node->findvalue($xpath_id_prestatario),
            nombre_comercial => $node->findvalue($xpath_nombre_comercial),
        });

        push @res, $lang;
    }

    return \@res;
}

1;
