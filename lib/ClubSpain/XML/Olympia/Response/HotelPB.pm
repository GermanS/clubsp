package ClubSpain::XML::Olympia::Response::HotelPB;

use strict;
use warnings;

use XML::LibXML;

use ClubSpain::XML::Olympia::HotelPB;

sub parse {
    my ($self, $string) = @_;

    my $dom  = XML::LibXML->load_xml( string => $string );
    my $root = XML::LibXML::XPathContext->new($dom);
    $root->registerNs( va => 'http://tempuri.org/' );

    my $xpath =
        new XML::LibXML::XPathExpression('/va:string/va:Respuesta/va:Establecimientos/va:Establecimiento');
    my $xpath_Codigo        = new XML::LibXML::XPathExpression('va:Codigo');
    my $xpath_Nombre        = new XML::LibXML::XPathExpression('va:Nombre');
    my $xpath_Direccion     = new XML::LibXML::XPathExpression('va:Direccion');
    my $xpath_Telefono      = new XML::LibXML::XPathExpression('va:Telefono');
    my $xpath_Email         = new XML::LibXML::XPathExpression('va:Email');
    my $xpath_Pais          = new XML::LibXML::XPathExpression('va:Pais');
    my $xpath_NombrePais    = new XML::LibXML::XPathExpression('va:NombrePais');
    my $xpath_Provincia     = new XML::LibXML::XPathExpression('va:Provincia');
    my $xpath_NombreProvincia = new XML::LibXML::XPathExpression('va:NombreProvincia');
    my $xpath_Poblacion       = new XML::LibXML::XPathExpression('va:Poblacion');
    my $xpath_NombrePoblacion = new XML::LibXML::XPathExpression('va:NombrePoblacion');
    my $xpath_Descripcion   = new XML::LibXML::XPathExpression('va:Descripcion');
    my $xpath_Categoria     = new XML::LibXML::XPathExpression('va:Categoria');
    my $xpath_Longitud      = new XML::LibXML::XPathExpression('va:Longitud');
    my $xpath_Latitud       = new XML::LibXML::XPathExpression('va:Latitud');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $xc = XML::LibXML::XPathContext->new($node);
        $xc->registerNs(va => 'http://tempuri.org/');
        my $object = ClubSpain::XML::Olympia::HotelPB->new({
            Codigo          => $xc->findvalue($xpath_Codigo),
            Nombre          => $xc->findvalue($xpath_Nombre),
            Direccion       => $xc->findvalue($xpath_Direccion),
            Telefono        => $xc->findvalue($xpath_Telefono),
            Email           => $xc->findvalue($xpath_Email),
            Pais            => $xc->findvalue($xpath_Pais),
            NombrePais      => $xc->findvalue($xpath_NombrePais),
            Provincia       => $xc->findvalue($xpath_Provincia),
            NombreProvincia => $xc->findvalue($xpath_NombreProvincia),
            Poblacion       => $xc->findvalue($xpath_Poblacion),
            NombrePoblacion => $xc->findvalue($xpath_NombrePoblacion),
            Descripcion     => $xc->findvalue($xpath_Descripcion),
            Categoria       => $xc->findvalue($xpath_Categoria),
            Longitud        => $xc->findvalue($xpath_Longitud),
            Latitud         => $xc->findvalue($xpath_Latitud),
        });

        push @res, $object;
    }

    return \@res;
}

1;
