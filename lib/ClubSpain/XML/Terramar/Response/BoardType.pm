package ClubSpain::XML::Terramar::Response::BoardType;

use strict;
use warnings;

use XML::LibXML;
use ClubSpain::XML::Terramar::BoardType;

sub parse {
    my ($self, $xml_sting) = @_;

    my $dom  = XML::LibXML->load_xml( string => $xml_sting );
    my $root   = $dom->getDocumentElement();
    my $xpath                    = new XML::LibXML::XPathExpression('/integracion/tipo_suplemento');
    my $xpath_id_tipo_suplemento = new XML::LibXML::XPathExpression('id_tipo_suplemento');
    my $xpath_nombre             = new XML::LibXML::XPathExpression('nombre');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $object = ClubSpain::XML::Terramar::BoardType->new({
            id_tipo_suplemento => $node->findvalue($xpath_id_tipo_suplemento),
            nombre => $node->findvalue($xpath_nombre),
        });

        push @res, $object;
    }

    return \@res;
}

1;
