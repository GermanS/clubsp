package ClubSpain::XML::Olympia::Response::City;

use strict;
use warnings;

use XML::LibXML;

sub parse {
    my ($self, $string) = @_;

    my $dom  = XML::LibXML->load_xml( string => $string );
    my $root = XML::LibXML::XPathContext->new($dom);
    $root->registerNs( va => 'http://tempuri.org/' );

    my $xpath =
        new XML::LibXML::XPathExpression('/va:string/va:Respuesta/va:Poblaciones/va:Poblacion');
    my $xpath_Pais_Codigo = new XML::LibXML::XPathExpression('va:Pais_Codigo');
    my $xpath_Provincia_Codigo = new XML::LibXML::XPathExpression('va:Provincia_Codigo');
    my $xpath_Poblacion_Codigo = new XML::LibXML::XPathExpression('va:Poblacion_Codigo');
    my $xpath_Poblacion_Nombre = new XML::LibXML::XPathExpression('va:Poblacion_Nombre');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $xc = XML::LibXML::XPathContext->new($node);
        $xc->registerNs(va => 'http://tempuri.org/');

        my $object = ClubSpain::XML::Olympia::City->new({
            Pais_Codigo      => $xc->findvalue($xpath_Pais_Codigo),
            Provincia_Codigo => $xc->findvalue($xpath_Provincia_Codigo),
            Poblacion_Codigo => $xc->findvalue($xpath_Poblacion_Codigo),
            Poblacion_Nombre => $xc->findvalue($xpath_Poblacion_Nombre),
        });

        push @res, $object;
    }

    return \@res;
}

1;
