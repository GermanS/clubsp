package ClubSpain::XML::Terramar::Request::HotelContract;

use strict;
use warnings;

use XML::LibXML;

sub request {
    my ($class, %params) = @_;
    
    my $doc = XML::LibXML::Document->new('1.0', 'utf-8');
    $doc->setStandalone(1);
    
    my $root = $doc->createElement('integracion');
    $root->setAttribute('accion', 'informeimprenta');
    
    my $id_articulo = $doc->createElement('id_articulo');
    $id_articulo->appendText($params{'id_articulo'})
        if defined $params{'id_articulo'};    
        
    my $id_idioma = $doc->createElement('id_idioma');
    $id_idioma->appendText($params{'id_idioma'})
        if defined $params{'id_idioma'};

    $root->appendChild($id_articulo);
    $root->appendChild($id_idioma);
    
    $doc->setDocumentElement($root);
    
    return $doc->toString(1);     
}

1;

__END__
=head1 request( id_articulo => , id_idioma => )

Запрос о контракта отеля
Форма запроса

<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<integracion accion="informeimprenta">
  <id_articulo>101</id_articulo>
  <id_idioma>0</id_idioma>
</integracion>

=cut
