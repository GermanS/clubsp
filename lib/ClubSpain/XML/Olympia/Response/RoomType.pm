package ClubSpain::XML::Olympia::Response::RoomType;

use strict;
use warnings;

use XML::LibXML;

use ClubSpain::XML::Olympia::RoomType;

sub parse {
    my ($self, $string) = @_;

    my $dom  = XML::LibXML->load_xml( string => $string );
    my $root = XML::LibXML::XPathContext->new($dom);
    $root->registerNs( va => 'http://tempuri.org/' );

    my $xpath =
        new XML::LibXML::XPathExpression('/va:string/va:Respuesta/va:TiposHabitacion/va:TipoHabitacion');
    my $xpath_CodigoTipoHabitacion = new XML::LibXML::XPathExpression('va:CodigoTipoHabitacion');
    my $xpath_DescripcionTipoHabitacion = new XML::LibXML::XPathExpression('va:DescripcionTipoHabitacion');


    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $xc = XML::LibXML::XPathContext->new($node);
        $xc->registerNs(va => 'http://tempuri.org/');

        my $object = ClubSpain::XML::Olympia::RoomType->new({
            CodigoTipoHabitacion      => $xc->findvalue($xpath_CodigoTipoHabitacion),
            DescripcionTipoHabitacion => $xc->findvalue($xpath_DescripcionTipoHabitacion),
        });

        push @res, $object;
    }

    return \@res;
}

1;
