package ClubSpain::XML::Terramar::Request::ProductType;

use strict;
use warnings;

use XML::LibXML;

sub request {
    my ($class, %params) = @_;
  
    my $doc = XML::LibXML::Document->new('1.0', 'utf-8');
    $doc->setStandalone(1);
    
    my $root = $doc->createElement('integracion');
    $root->setAttribute('accion', 'clases');
  
    my $id_idioma = $doc->createElement('id_idioma');
    $id_idioma->appendText($params{'id_idioma'})
        if defined $params{'id_idioma'};

    my $id_tipo_articulo_superclase = $doc->createElement('id_tipo_articulo_superclase');
    $id_tipo_articulo_superclase->appendText($params{'id_tipo_articulo_superclase'})
        if defined $params{'id_tipo_articulo_superclase'};

    $root->appendChild($id_idioma);
    $root->appendChild($id_tipo_articulo_superclase);    
    
    $doc->setDocumentElement($root);
    
    return $doc->toString(1);
}

1;

__END__

=head1 request( id_tipo_articulo_superclase => , id_idioma =>  )

Запрос партнеру списка типов турпродукта
Форма запроса

<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<integracion accion="clases">
  <id_idioma>10</id_idioma>
  <id_tipo_articulo_superclase>11</id_tipo_articulo_superclase>
</integracion>

=cut
