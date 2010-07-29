package ClubSpain::XML::Olympia::Response::BoardTypePB;

use strict;
use warnings;

use XML::LibXML;

use ClubSpain::XML::Olympia::BoardTypePB;

sub parse {
    my ($self, $string) = @_;

    my $dom  = XML::LibXML->load_xml( string => $string );
    my $root = XML::LibXML::XPathContext->new($dom);
    $root->registerNs( va => 'http://tempuri.org/' );

    my $xpath =
        new XML::LibXML::XPathExpression('/va:string/va:Respuesta/va:Regimenes/va:Regimen');
    my $xpath_RegimenCodigo   = new XML::LibXML::XPathExpression('va:RegimenCodigo');
    my $xpath_TraduccionTexto = new XML::LibXML::XPathExpression('va:TraduccionTexto');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $xc = XML::LibXML::XPathContext->new($node);
        $xc->registerNs(va => 'http://tempuri.org/');

        my $object = ClubSpain::XML::Olympia::BoardTypePB->new({
            RegimenCodigo   => $xc->findvalue($xpath_RegimenCodigo),
            TraduccionTexto => $xc->findvalue($xpath_TraduccionTexto)
        });

        push @res, $object;
    }

    return \@res;
}

1;
