package ClubSpain::XML::Olympia::Response::Country;

use strict;
use warnings;

use XML::LibXML;
use ClubSpain::XML::Olympia::Country;

sub parse {
    my ($self, $string) = @_;

    my $dom  = XML::LibXML->load_xml( string => $string );
    my $root = XML::LibXML::XPathContext->new($dom);
    $root->registerNs( va => 'http://tempuri.org/' );

    my $xpath =
        new XML::LibXML::XPathExpression('/va:string/va:Respuesta/va:Paises/va:Pais');
    my $xpath_Codigo = new XML::LibXML::XPathExpression('va:Codigo_Pais');
    my $xpath_Nombre = new XML::LibXML::XPathExpression('va:Nombre_pais');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $xc = XML::LibXML::XPathContext->new($node);
        $xc->registerNs(va => 'http://tempuri.org/');

        my $object = ClubSpain::XML::Olympia::Country->new({
            Codigo_Pais => $xc->findvalue($xpath_Codigo),
            Nombre_pais => $xc->findvalue($xpath_Nombre),
        });

        push @res, $object;
    }

    return \@res;
}

1;
