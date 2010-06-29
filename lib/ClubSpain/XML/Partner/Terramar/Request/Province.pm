package ClubSpain::XML::Partner::Terramar::Request::Province;

use strict;
use warnings;

use XML::LibXML;

sub request {
    my ($class, %params) = @_;
  
    my $doc = XML::LibXML::Document->new('1.0', 'utf-8');
    $doc->setStandalone(1);
    
    my $root = $doc->createElement('integracion');
    $root->setAttribute('accion', 'provincias');

    my $id_tipo_articulo_clase = $doc->createElement('id_tipo_articulo_clase');
    $id_tipo_articulo_clase->appendText(1);
    
    my $id_zona = $doc->createElement('id_zona');
    $id_zona->appendText($params{'zona_id'});

    $root->appendChild($id_tipo_articulo_clase);
    $root->appendChild($id_zona);
    
    $doc->setDocumentElement($root);
    
    return $doc->toString(1);
}

1;
