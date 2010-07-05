package ClubSpain::XML::Terramar::Request::Hotel;

use strict;
use warnings;

use XML::LibXML;

sub request {
    my ($class, %params) = @_;
  
    my $doc = XML::LibXML::Document->new('1.0', 'utf-8');
    $doc->setStandalone(1);
    
    my $root = $doc->createElement('integracion');
    $root->setAttribute('accion', 'prestatarios');   
    
    my $id_tipo_articulo_clase = $doc->createElement('id_tipo_articulo_clase');
    $id_tipo_articulo_clase->appendText($params{'id_tipo_articulo_clase'})
        if defined $params{'id_tipo_articulo_clase'};
    
    my $provincia = $doc->createElement('provincia');
    $provincia->appendText($params{'provincia'})
        if defined $params{'provincia'};
    
    my $id_zona = $doc->createElement('id_zona');
    $id_zona->appendText($params{'id_zona'})
        if defined $params{'id_zona'};
    
    my $info_extendida = $doc->createElement('info_extendida');
    $info_extendida->appendText($params{'info_extendida'})
        if defined $params{'info_extendida'};
    
    my $poblacion = $doc->createElement('poblacion');
    $poblacion->appendText($params{'poblacion'})
        if defined $params{'poblacion'};
    
    my $id_idioma = $doc->createElement('id_idioma');
    $id_idioma->appendText($params{'id_idioma'})
        if defined $params{'id_idioma'};
    
    
    $root->appendChild($id_tipo_articulo_clase);
    $root->appendChild($provincia);
    $root->appendChild($id_zona);
    $root->appendChild($info_extendida);
    $root->appendChild($poblacion);
    $root->appendChild($id_idioma);
    
    $doc->setDocumentElement($root);
    
    return $doc->toString(1);    
}

1;

__END__

=head1 request( provincia => , zona_id => , info_extendida => , poblacion => , id_idioma => )

Запрос партнеру списка отелей для выбраной зоны, области, города
Форма запроса

<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<integracion accion="prestatarios">
  <id_tipo_articulo_clase>2</id_tipo_articulo_clase>
  <provincia></provincia>
  <id_zona>1322</id_zona>
  <info_extendida>0</info_extendida>
  <poblacion>LLORET DE MAR</poblacion>
  <id_idioma>3</id_idioma>
</integracion>

=cut
