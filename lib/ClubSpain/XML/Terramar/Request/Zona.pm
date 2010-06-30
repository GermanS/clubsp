package ClubSpain::XML::Terramar::Request::Zona;

use strict;
use warnings;

use XML::LibXML;

sub request {
    my ($class, %params) = @_;
  
    my $doc = XML::LibXML::Document->new('1.0', 'utf-8');
    $doc->setStandalone(1);
    
    my $root = $doc->createElement('integracion');
    $root->setAttribute('accion', 'zonas');

    my $id_tipo_articulo_clase = $doc->createElement('id_tipo_articulo_clase');
    $id_tipo_articulo_clase->appendText(1);
    
    my $id_zona_pais = $doc->createElement('id_zona_pais');
    $id_zona_pais->appendText($params{'id_zona_pais'})
        if defined $params{'id_zona_pais'};

    $root->appendChild($id_tipo_articulo_clase);
    $root->appendChild($id_zona_pais);
    
    $doc->setDocumentElement($root);
    
    return $doc->toString(1);
}

1;

__END__

=head1 request( id_zona_pais => $id )

Запрос партнеру списка зон выбранной страны
Форма запроса

<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<integracion accion="zonas">
  <id_tipo_articulo_clase>1</id_tipo_articulo_clase>
  <id_zona_pais>1</id_zona_pais>
</integracion>


=cut


