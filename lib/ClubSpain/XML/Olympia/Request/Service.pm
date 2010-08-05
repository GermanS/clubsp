package ClubSpain::XML::Olympia::Request::Service;

use strict;
use warnings;

use XML::LibXML;

sub request {
    my ( $self, %params ) = @_;

    my $doc = XML::LibXML::Document->new('1.0', 'utf-8');

    my $root = $doc->createElement('DevuelveServicios');
    $root->setAttribute('xmlns', 'http://tempuri.org/');

    my $user = $doc->createElement('User');
    $user->appendText($params{'user'})
        if defined $params{'user'};

    my $password = $doc->createElement('password');
    $password->appendText($params{'password'})
        if defined $params{'password'};

    my $codigo_proveedor = $doc->createElement('CodigoProveedor');
    $codigo_proveedor->appendText($params{'codigo_proveedor'})
        if defined $params{'codigo_proveedor'};

    my $fecha_inicial = $doc->createElement('FechaInicial');
    $fecha_inicial->appendText($params{'fecha_inicial'})
        if defined $params{'fecha_inicial'};

    my $fecha_final = $doc->createElement('FechaFinal');
    $fecha_final->appendText($params{'fecha_final'})
        if defined $params{'fecha_final'};

    my $mercado = $doc->createElement('IdMercado');

    $root->appendChild($user);
    $root->appendChild($password);
    $root->appendChild($codigo_proveedor);
    $root->appendChild($fecha_inicial);
    $root->appendChild($fecha_final);
    $root->appendChild($mercado);


    $doc->setDocumentElement($root);

    return $doc->toString(1);
}

1;
