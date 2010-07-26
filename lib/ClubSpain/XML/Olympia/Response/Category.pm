package ClubSpain::XML::Olympia::Response::Category;

use strict;
use warnings;

use XML::LibXML;
use ClubSpain::XML::Olympia::Category;

sub parse {
    my ($self, $string) = @_;

    my $dom  = XML::LibXML->load_xml( string => $string );
    my $root = XML::LibXML::XPathContext->new($dom);
    $root->registerNs( va => 'http://tempuri.org/' );

    my $xpath =
        new XML::LibXML::XPathExpression('/va:string/va:Respuesta/va:Categorias/va:Categoria');
    my $xpath_CodigoCategoria = new XML::LibXML::XPathExpression('va:CodigoCategoria');
    my $xpath_NombreCategoria = new XML::LibXML::XPathExpression('va:NombreCategoria');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $xc = XML::LibXML::XPathContext->new($node);
        $xc->registerNs(va => 'http://tempuri.org/');

        my $object = ClubSpain::XML::Olympia::Category->new({
            CodigoCategoria => $xc->findvalue($xpath_CodigoCategoria),
            NombreCategoria => $xc->findvalue($xpath_NombreCategoria),
        });

        push @res, $object;
    }

    return \@res;
}

1;
