package ClubSpain::XML::Olympia::Response::HotelAvailability;

use strict;
use warnings;

use XML::LibXML;
use ClubSpain::XML::Olympia::HotelAvailability;

sub parse {
    my ($self, $string) = @_;

    my $dom  = XML::LibXML->load_xml( string => $string );
    my $root = XML::LibXML::XPathContext->new($dom);
    $root->registerNs( va => 'http://tempuri.org/' );

    my $xpath =
        new XML::LibXML::XPathExpression('/va:string/va:Respuesta/va:Disponibilidad');
    my $xpath_CodigoPeticion =
        new XML::LibXML::XPathExpression('va:CodigoPeticion');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $xc = XML::LibXML::XPathContext->new($node);
        $xc->registerNs(va => 'http://tempuri.org/');

        my $object = ClubSpain::XML::Olympia::HotelAvailability->new({
            CodigoPeticion => $xc->findvalue($xpath_CodigoPeticion),
            hotel          => $self->__parse_hotel($node),
        });

        push @res, $object;
    }

    return \@res;
}

sub __parse_hotel {
    my ( $self, $dom ) = @_;

    my $root = XML::LibXML::XPathContext->new($dom);
    $root->registerNs(va => 'http://tempuri.org/');

    my $xpath                   = new XML::LibXML::XPathExpression('va:Hoteles/va:Hotel');
    my $xpath_Codigo            = new XML::LibXML::XPathExpression('va:Codigo');
    my $xpath_Nombre            = new XML::LibXML::XPathExpression('va:Nombre');
    my $xpath_CodigoPais        = new XML::LibXML::XPathExpression('va:CodigoPais');
    my $xpath_CodigoProvincia   = new XML::LibXML::XPathExpression('va:CodigoProvincia');
    my $xpath_NombreProvincia   = new XML::LibXML::XPathExpression('va:NombreProvincia');
    my $xpath_Poblacion         = new XML::LibXML::XPathExpression('va:Poblacion');
    my $xpath_Categoria         = new XML::LibXML::XPathExpression('va:Categoria');
    my $xpath_FechaEntrada      = new XML::LibXML::XPathExpression('va:FechaEntrada');
    my $xpath_FechaSalida       = new XML::LibXML::XPathExpression('va:FechaSalida');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $xc = XML::LibXML::XPathContext->new($node);
        $xc->registerNs(va => 'http://tempuri.org/');

        my $object = ClubSpain::XML::Olympia::HotelAvailability::Hotel->new({
            Codigo            => $xc->findvalue($xpath_Codigo),
            Nombre            => $xc->findvalue($xpath_Nombre),
            CodigoPais        => $xc->findvalue($xpath_CodigoPais),
            CodigoProvincia   => $xc->findvalue($xpath_CodigoProvincia),
            NombreProvincia   => $xc->findvalue($xpath_NombreProvincia),
            Poblacion         => $xc->findvalue($xpath_Poblacion),
            Categoria         => $xc->findvalue($xpath_Categoria),
            FechaEntrada      => $xc->findvalue($xpath_FechaEntrada),
            FechaSalida       => $xc->findvalue($xpath_FechaSalida),
            room              => $self->__parse_room($node)
        });

        push @res, $object;
    }

    return \@res;
}

sub __parse_room {
    my ( $self, $dom ) = @_;

    my $root = XML::LibXML::XPathContext->new($dom);
    $root->registerNs(va => 'http://tempuri.org/');

    my $xpath               = new XML::LibXML::XPathExpression('va:HabitacionesList/va:Habitacion');
    my $xpath_Habitacion    = new XML::LibXML::XPathExpression('@Ord');
    my $xpath_Adultos       = new XML::LibXML::XPathExpression('va:Adultos');
    my $xpath_ninos         = new XML::LibXML::XPathExpression('va:ninos/va:edad');
    my $xpath_numhab        = new XML::LibXML::XPathExpression('va:numhab');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $xc = XML::LibXML::XPathContext->new($node);
        $xc->registerNs(va => 'http://tempuri.org/');

        my $object = ClubSpain::XML::Olympia::HotelAvailability::Room->new({
            Habitacion  => $xc->findvalue($xpath_Habitacion),
            Adultos     => $xc->findvalue($xpath_Adultos),
            numhab      => $xc->findvalue($xpath_numhab),

            ninos       => $self->__parse_child($node),
            date        => $self->__parse_date($node),
        });

        push @res, $object;
    }

    return \@res;
}

sub __parse_child {
    my ( $self, $dom ) = @_;

    my $root = XML::LibXML::XPathContext->new($dom);
    $root->registerNs(va => 'http://tempuri.org/');

    my $xpath      = new XML::LibXML::XPathExpression('va:ninos');
    my $xpath_edad = new XML::LibXML::XPathExpression('va:edad');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $xc = XML::LibXML::XPathContext->new($node);
        $xc->registerNs(va => 'http://tempuri.org/');

        my $object = ClubSpain::XML::Olympia::HotelAvailability::Child->new({
            age => $xc->findvalue($xpath_edad)
        });

        push @res, $object;
    }

    return \@res;
}

sub __parse_date {
    my ( $self, $dom ) = @_;

    my $root = XML::LibXML::XPathContext->new($dom);
    $root->registerNs(va => 'http://tempuri.org/');

    my $xpath                = new XML::LibXML::XPathExpression('va:DatosHabitacion');
    my $xpath_Servicio       = new XML::LibXML::XPathExpression('va:Servicio');
    my $xpath_CodigoServicio = new XML::LibXML::XPathExpression('va:CodigoServicio');
    my $xpath_CodigoConcepto = new XML::LibXML::XPathExpression('va:CodigoConcepto');
    my $xpath_regimen        = new XML::LibXML::XPathExpression('va:regimen');
    my $xpath_disponible     = new XML::LibXML::XPathExpression('va:disponible');
    my $xpath_precio         = new XML::LibXML::XPathExpression('va:precio');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $xc = XML::LibXML::XPathContext->new($node);
        $xc->registerNs(va => 'http://tempuri.org/');

        my $object = ClubSpain::XML::Olympia::HotelAvailability::Date->new({
            Servicio        => $xc->findvalue($xpath_Servicio),
            CodigoServicio  => $xc->findvalue($xpath_CodigoServicio),
            CodigoConcepto  => $xc->findvalue($xpath_CodigoConcepto),
            regimen         => $xc->findvalue($xpath_regimen),
            disponible      => $xc->findvalue($xpath_disponible),
            precio          => $xc->findvalue($xpath_precio),

            option          => $self->__parse_option($node),
        });

        push @res, $object;
    }

    return \@res;
}

sub __parse_option {
    my ( $self, $dom ) = @_;

    my $root = XML::LibXML::XPathContext->new($dom);
    $root->registerNs(va => 'http://tempuri.org/');

    my $xpath               = new XML::LibXML::XPathExpression('va:ObservacionesList');
    my $xpath_Observaciones = new XML::LibXML::XPathExpression('va:Observaciones');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $xc = XML::LibXML::XPathContext->new($node);
        $xc->registerNs(va => 'http://tempuri.org/');

        my $object = ClubSpain::XML::Olympia::HotelAvailability::Option->new({
            Observaciones => $xc->findvalue($xpath_Observaciones)
        });
        push @res, $object;
    }


    return \@res;
}

1;
