package ClubSpain::XML::Terramar::Request::HotelAvailability;

use strict;
use warnings;

use XML::LibXML;

sub request {
    my ($class, %params) = @_;
    
    my $doc = XML::LibXML::Document->new('1.0', 'utf-8');
    $doc->setStandalone(1);
    
    my $root = $doc->createElement('integracion');
    $root->setAttribute('accion', 'rangosdisponibilidad');

    my $id_articulo = $doc->createElement('id_articulo');
    $id_articulo->appendText($params{'id_articulo'})
        if defined $params{'id_articulo'};    

    $root->appendChild($id_articulo);
    
    $doc->setDocumentElement($root);
    
    return $doc->toString(1); 
}

1;

__END__

=head1 request( id_articulo => )

Запрос о возможности бронирования отеля
Форма запроса

<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<integracion accion="rangosdisponibilidad">
  <id_articulo>101</id_articulo>
</integracion>

=cut 
