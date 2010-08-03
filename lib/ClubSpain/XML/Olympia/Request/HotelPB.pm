package ClubSpain::XML::Olympia::Request::HotelPB;

use strict;
use warnings;

use XML::LibXML;

sub request {
    my ( $self, %params ) = @_;

    my $doc = XML::LibXML::Document->new('1.0', 'utf-8');

    my $root = $doc->createElement('DevuelveEstablecimientosPB');
    $root->setAttribute('xmlns', 'http://tempuri.org/');

    my $user = $doc->createElement('User');
    $user->appendText($params{'user'})
        if defined $params{'user'};

    my $password = $doc->createElement('password');
    $password->appendText($params{'password'})
        if defined $params{'password'};

    my $pais = $doc->createElement('Pais');
    $pais->appendText($params{'pais'})
        if defined $params{'pais'};

    my $provincia = $doc->createElement('Provincia');
    $provincia->appendText($params{'provincia'})
        if defined $params{'provincia'};

    my $poblacion = $doc->createElement('Poblacion');
    $poblacion->appendText($params{'poblacion'})
        if defined $params{'poblacion'};

    my $opciones = $doc->createElement('Opciones');
    my $idioma   = $doc->createElement('Idioma');
    $idioma->appendText($params{'idioma'})
        if defined $params{'idioma'};
    $opciones->appendChild($idioma);

    $root->appendChild($user);
    $root->appendChild($password);
    $root->appendChild($pais);
    $root->appendChild($provincia);
    $root->appendChild($poblacion);
    $root->appendChild($opciones);

    $doc->setDocumentElement($root);

    return $doc->toString(1);
}

1;
