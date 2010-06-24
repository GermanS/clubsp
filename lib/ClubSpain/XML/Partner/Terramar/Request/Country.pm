package ClubSpain::XML::Partner::Terramar::Request::Country;

use strict;
use warnings;

use XML::LibXML;
use HTTP::Request;

sub request {
    my $doc = XML::LibXML::Document->new('1.0', 'utf-8');
    $doc->setStandalone(1);
    
    my $root = $doc->createElement('integracion');
    $root->setAttribute('accion', 'paises');

    my $id_tipo_articulo_clase = $doc->createElement('id_tipo_articulo_clase');
    $id_tipo_articulo_clase->appendText(1);

    $root->appendChild($id_tipo_articulo_clase);
    $doc->setDocumentElement($root);
    
    return $doc->toString(1);
}

1;

__END__
