package ClubSpain::XML::Olympia::Response::BoardType;

use strict;
use warnings;

use XML::LibXML;
use ClubSpain::XML::Olympia::BoardType;

sub parse {
    my ($self, $string) = @_;

    my $dom  = XML::LibXML->load_xml( string => $string );
    my $root = XML::LibXML::XPathContext->new($dom);
    $root->registerNs( va => 'http://tempuri.org/' );

    my $xpath =
        new XML::LibXML::XPathExpression('/va:string/va:Respuesta/va:Regimenes/va:Regimen');
    my $xpath_RegimenCodigo      = new XML::LibXML::XPathExpression('va:RegimenCodigo');
    my $xpath_RegimenDescripcion = new XML::LibXML::XPathExpression('va:RegimenDescripcion');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $xc = XML::LibXML::XPathContext->new($node);
        $xc->registerNs(va => 'http://tempuri.org/');

        my $object = ClubSpain::XML::Olympia::BoardType->new({
            RegimenCodigo      => $xc->findvalue($xpath_RegimenCodigo),
            RegimenDescripcion => $xc->findvalue($xpath_RegimenDescripcion)
        });

        push @res, $object;
    }

    return \@res;
}

1;
