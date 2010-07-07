package ClubSpain::XML::Terramar::Request::Occupation;

use strict;
use warnings;

use XML::LibXML;

sub request {
    my ($class, %params) = @_;
  
    my $doc = XML::LibXML::Document->new('1.0', 'utf-8');
    $doc->setStandalone(1);
    
    my $root = $doc->createElement('integracion');
    $root->setAttribute('accion', 'ocupaciones');

    my $id_tipo_articulo_clase = $doc->createElement('id_tipo_articulo_clase');
    $id_tipo_articulo_clase->appendText($params{'id_tipo_articulo_clase'})
        if defined $params{'id_tipo_articulo_clase'};
    
    $root->appendChild($id_tipo_articulo_clase);
    
    $doc->setDocumentElement($root);
    
    return $doc->toString(1);
}

1;

__END__

=head1 request( id_tipo_articulo_clase =>  )

Запрос партнеру максимальногого и минимального количества туристов
Форма запроса

<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<integracion accion="ocupaciones">
  <id_tipo_articulo_clase>99</id_tipo_articulo_clase>
</integracion>

=cut

1;
