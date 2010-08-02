package ClubSpain::XML::Olympia::Request::Pictogram;

use strict;
use warnings;

use XML::LibXML;

sub request {
    my ( $self, %params ) = @_;

    my $doc = XML::LibXML::Document->new('1.0', 'utf-8');

    my $root = $doc->createElement('DevuelveSimbolos');
    $root->setAttribute('xmlns', 'http://tempuri.org/');

    my $user = $doc->createElement('User');
    $user->appendText($params{'user'})
        if defined $params{'user'};

    my $password = $doc->createElement('password');
    $password->appendText($params{'password'})
        if defined $params{'password'};

    my $establecimiento = $doc->createElement('Establecimiento');
    $establecimiento->appendText($params{'establecimiento'})
        if defined $params{'establecimiento'};

    $root->appendChild($user);
    $root->appendChild($password);
    $root->appendChild($establecimiento);

    $doc->setDocumentElement($root);

    return $doc->toString(1);
}

1;
