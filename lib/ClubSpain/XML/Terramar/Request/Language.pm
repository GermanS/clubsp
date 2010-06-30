package ClubSpain::XML::Terramar::Request::Language;

use strict;
use warnings;

use XML::LibXML;

sub request {
    my ($class, %params) =  @_;
    
    my $doc = XML::LibXML::Document->new('1.0', 'utf-8');
    $doc->setStandalone(1);
    
    my $root = $doc->createElement('integracion');
    $root->setAttribute('accion', 'idiomas');
    
    $doc->setDocumentElement($root);
    
    return $doc->toString(1);    
}

1;

__END__

=head1 request()

Запрос партнеру списка доступных языков
Форма запроса

<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<integracion accion="idiomas"/>

=cut

