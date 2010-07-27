package ClubSpain::XML::Olympia::Response::Province;

use strict;
use warnings;

use XML::LibXML;

use ClubSpain::XML::Olympia::Province;

sub parse {
    my ($self, $string) = @_;

    my $dom  = XML::LibXML->load_xml( string => $string );
    my $root = XML::LibXML::XPathContext->new($dom);
    $root->registerNs( va => 'http://tempuri.org/' );

    my $xpath =
        new XML::LibXML::XPathExpression('/va:string/va:Respuesta/va:Provincias/va:Provincia');
    my $xpath_Pais_Codigo = new XML::LibXML::XPathExpression('va:Pais_Codigo');
    my $xpath_Provincia_Codigo = new XML::LibXML::XPathExpression('va:Provincia_Codigo');
    my $xpath_Provincia_Nombre = new XML::LibXML::XPathExpression('va:Provincia_Nombre');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $xc = XML::LibXML::XPathContext->new($node);
        $xc->registerNs(va => 'http://tempuri.org/');

        my $object = ClubSpain::XML::Olympia::Province->new({
            Pais_Codigo      => $xc->findvalue($xpath_Pais_Codigo),
            Provincia_Codigo => $xc->findvalue($xpath_Provincia_Codigo),
            Provincia_Nombre => $xc->findvalue($xpath_Provincia_Nombre),
        });

        push @res, $object;
    }

    return \@res;
}

1;
