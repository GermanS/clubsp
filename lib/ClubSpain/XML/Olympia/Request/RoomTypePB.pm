package ClubSpain::XML::Olympia::Request::RoomTypePB;

use strict;
use warnings;

use XML::LibXML;

sub request {
    my ( $self, %params ) = @_;

    my $doc = XML::LibXML::Document->new('1.0', 'utf-8');

    my $root = $doc->createElement('DevuelveRegimenesPB');
    $root->setAttribute('xmlns', 'http://tempuri.org/');

    my $user = $doc->createElement('User');
    $user->appendText($params{'user'})
        if defined $params{'user'};

    my $password = $doc->createElement('password');
    $password->appendText($params{'password'})
        if defined $params{'password'};

    my $option = $doc->createElement('Opciones');

    my $idioma = $doc->createElement('Idioma');
    $idioma->appendText($params{'idioma'})
        if defined $params{'idioma'};

    $option->appendChild($idioma);

    $root->appendChild($user);
    $root->appendChild($password);
    $root->appendChild($option);

    $doc->setDocumentElement($root);

    return $doc->toString(1);
}

1;
