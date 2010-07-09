package ClubSpain::XML::Terramar::Request::HotelActiveContract;

use strict;
use warnings;

use XML::LibXML;

sub request {
    my ($class, %params) = @_;
    
    my $doc = XML::LibXML::Document->new('1.0', 'utf-8');
    $doc->setStandalone(1);
    
    my $root = $doc->createElement('integracion');
    $root->setAttribute('accion', 'articulosactivos');

    my $id_prestatario = $doc->createElement('id_prestatario');
    $id_prestatario->appendText($params{'id_prestatario'})
        if defined $params{'id_prestatario'};

    my $id_idioma = $doc->createElement('id_idioma');
    $id_idioma->appendText($params{'id_idioma'})
        if defined $params{'id_idioma'};

    my $id_tipo_articulo_clase = $doc->createElement('id_tipo_articulo_clase');
    $id_tipo_articulo_clase->appendText($params{'id_tipo_articulo_clase'})
        if defined $params{'id_tipo_articulo_clase'};

    $root->appendChild($id_prestatario);
    $root->appendChild($id_idioma);
    $root->appendChild($id_tipo_articulo_clase);
    
    $doc->setDocumentElement($root);
    
    return $doc->toString(1);    
}

1;

__END__

=head1 request( id_prestatario => , id_idioma => , id_tipo_articulo_clase => )

Запрос о активных контрактах отеля
Форма запроса

<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<integracion accion="articulosactivos">
  <id_prestatario>1</id_prestatario>
  <id_idioma>0</id_idioma>
  <id_tipo_articulo_clase>1</id_tipo_articulo_clase>
</integracion>


=cut

1;
