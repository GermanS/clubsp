package ClubSpain::XML::Olympia::Response::Pictogram;

use strict;
use warnings;

use XML::LibXML;

use ClubSpain::XML::Olympia::Pictogram;

sub parse {
    my ($self, $string) = @_;

    my $dom  = XML::LibXML->load_xml( string => $string );
    my $root = XML::LibXML::XPathContext->new($dom);
    $root->registerNs( va => 'http://tempuri.org/' );

    my $xpath =
        new XML::LibXML::XPathExpression('/va:string/va:Respuesta/va:Simbolos/va:Simbolo');
    my $xpath_Codigo      = new XML::LibXML::XPathExpression('va:Codigo');
    my $xpath_Descripcion = new XML::LibXML::XPathExpression('va:Descripcion');
    my $xpath_Url         = new XML::LibXML::XPathExpression('va:Url');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $xc = XML::LibXML::XPathContext->new($node);
        $xc->registerNs(va => 'http://tempuri.org/');

        my $object = ClubSpain::XML::Olympia::Pictogram->new({
            Codigo      => $xc->findvalue($xpath_Codigo),
            Descripcion => $xc->findvalue($xpath_Descripcion),
            Url         => $xc->findvalue($xpath_Url),
        });

        push @res, $object;
    }

    return \@res;
}

1;
