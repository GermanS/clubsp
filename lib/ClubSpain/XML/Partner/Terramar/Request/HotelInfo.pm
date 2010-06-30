package ClubSpain::XML::Partner::Terramar::Request::HotelInfo;

use strict;
use warnings;

use XML::LibXML;

sub request {
    my ($class, %params) = @_;
    
    my $doc = XML::LibXML::Document->new('1.0', 'utf-8');
    $doc->setStandalone(1);
    
    my $root = $doc->createElement('integracion');
    $root->setAttribute('accion', 'fichatecnicaprestatario');

    my $id_prestatario = $doc->createElement('id_prestatario');
    $id_prestatario->appendText($params{'id_prestatario'})
        if defined $params{'id_prestatario'};

    my $id_idioma = $doc->createElement('id_idioma');
    $id_idioma->appendText($params{'id_idioma'})
        if defined $params{'id_idioma'};

    $root->appendChild($id_prestatario);
    $root->appendChild($id_idioma);
    
    $doc->setDocumentElement($root);
    
    return $doc->toString(1);
}

1;

__END__

=head1 request( id_prestatario => , id_idioma => )

Запрос партнеру расширеной информации по отелю
Форма запроса

<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<integracion accion="fichatecnicaprestatario">
  <id_prestatario>1</id_prestatario>
  <id_idioma>0</id_idioma>
</integracion>



=cut
