package ClubSpain::XML::Partner::Terramar::Request::City;

use strict;
use warnings;

use XML::LibXML;

sub request {
    my ($class, %params) = @_;
  
    my $doc = XML::LibXML::Document->new('1.0', 'utf-8');
    $doc->setStandalone(1);
    
    my $root = $doc->createElement('integracion');
    $root->setAttribute('accion', 'poblaciones');

    my $id_tipo_articulo_clase = $doc->createElement('id_tipo_articulo_clase');
    $id_tipo_articulo_clase->appendText(1);
    
    my $id_zona = $doc->createElement('id_zona');
    $id_zona->appendText($params{'id_zona'})
        if defined $params{'id_zona'};

    $root->appendChild($id_tipo_articulo_clase);
    $root->appendChild($id_zona);
    
    $doc->setDocumentElement($root);
    
    return $doc->toString(1);
}

1;

__END__

=head1 request( id_zona => $id )

Запрос партнеру списка городов для выбраной зоны
Форма запроса

<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<integracion accion="poblaciones">
  <id_tipo_articulo_clase>1</id_tipo_articulo_clase>
  <id_zona>1</id_zona>
</integracion>

=cut

