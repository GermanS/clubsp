package ClubSpain::XML::Olympia::Request::City;

use strict;
use warnings;

use XML::LibXML;

sub request {
    my ( $self, %params ) = @_;

    my $doc = XML::LibXML::Document->new('1.0', 'utf-8');

    my $root = $doc->createElement('DevuelvePoblaciones');
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

    $root->appendChild($user);
    $root->appendChild($password);
    $root->appendChild($pais);
    $root->appendChild($provincia);

    $doc->setDocumentElement($root);

    return $doc->toString(1);
};

1;