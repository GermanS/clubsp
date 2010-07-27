package ClubSpain::XML::Olympia::Response::Language;

use strict;
use warnings;

use XML::LibXML;

use ClubSpain::XML::Olympia::Language;

sub parse {
    my ($self, $string) = @_;

    my $dom  = XML::LibXML->load_xml( string => $string );
    my $root = XML::LibXML::XPathContext->new($dom);
    $root->registerNs( va => 'http://tempuri.org/' );

    my $xpath =
        new XML::LibXML::XPathExpression('/va:string/va:Respuesta/va:Idiomas/va:Idioma');
    my $xpath_Codigo = new XML::LibXML::XPathExpression('va:Codigo');
    my $xpath_Descripcion = new XML::LibXML::XPathExpression('va:Descripcion');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $xc = XML::LibXML::XPathContext->new($node);
        $xc->registerNs(va => 'http://tempuri.org/');

        my $object = ClubSpain::XML::Olympia::Language->new({
            Codigo      => $xc->findvalue($xpath_Codigo),
            Descripcion => $xc->findvalue($xpath_Descripcion)
        });

        push @res, $object;
    }

    return \@res;
}

1;
