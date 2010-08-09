package ClubSpain::XML::Olympia::Response::Service;
package ClubSpain::XML::Olympia::Response::Service;

use strict;
use warnings;

use XML::LibXML;
use ClubSpain::XML::Olympia::Service;

sub parse {
    my ($self, $string) = @_;

    my $dom  = XML::LibXML->load_xml( string => $string );
    my $root = XML::LibXML::XPathContext->new($dom);
    $root->registerNs( va => 'http://tempuri.org/' );

    my $xpath
        = new XML::LibXML::XPathExpression('/va:string/va:Respuesta');
    my $xpath_CodigoProveedor
        = new XML::LibXML::XPathExpression('va:CodigoProveedor');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $xc = XML::LibXML::XPathContext->new($node);
        $xc->registerNs(va => 'http://tempuri.org/');

        my $object = ClubSpain::XML::Olympia::Service->new({
            CodigoProveedor => $xc->findvalue($xpath_CodigoProveedor),
            Servicio        => $self->__parse_servicio($node),
        });

        push @res, $object;
    }

    return \@res;
}

sub __parse_servicio {
    my ( $self,  $dom ) = @_;

    my $root = XML::LibXML::XPathContext->new($dom);
    $root->registerNs(va => 'http://tempuri.org/');

    my $xpath = new XML::LibXML::XPathExpression('va:Servicios/va:Servicio');

    my $xpath_Codigo
        = new XML::LibXML::XPathExpression('va:Codigo');
    my $xpath_CodigoConcepto
        = new XML::LibXML::XPathExpression('va:CodigoConcepto');
    my $xpath_Descripcion
        = new XML::LibXML::XPathExpression('va:Descripcion');
    my $xpath_Regimen
        = new XML::LibXML::XPathExpression('va:Regimen');
    my $xpath_PaxFijas
        = new XML::LibXML::XPathExpression('va:PaxFijas');
    my $xpath_Paquete
        = new XML::LibXML::XPathExpression('va:Paquete');
    my $xpath_OfertasAxB
        = new XML::LibXML::XPathExpression('va:OfertasAxB');
    my $xpath_PaxMaximasHabitacion
        = new XML::LibXML::XPathExpression('va:PaxMaximasHabitacion');
    my $xpath_PaxMinimas
        = new XML::LibXML::XPathExpression('va:PaxMinimas');
    my $xpath_PaxMaximas
        = new XML::LibXML::XPathExpression('va:PaxMaximas');
    my $xpath_Maximos3aPax
        = new XML::LibXML::XPathExpression('va:Maximos3aPax');
    my $xpath_NinosMaximos
        = new XML::LibXML::XPathExpression('va:NinosMaximos');
    my $xpath_LimiteEdadNinosInferior
        = new XML::LibXML::XPathExpression('va:LimiteEdadNinosInferior');
    my $xpath_LimiteEdadNinos
        = new XML::LibXML::XPathExpression('va:LimiteEdadNinos');
    my $xpath_EntradasNoPermitidasList
        = new XML::LibXML::XPathExpression('va:EntradasNoPermitidasList');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $xc = XML::LibXML::XPathContext->new($node);
        $xc->registerNs(va => 'http://tempuri.org/');

        my $object = ClubSpain::XML::Olympia::Service::Serving->new({
            Codigo
                => $xc->findvalue($xpath_Codigo),
            CodigoConcepto
                => $xc->findvalue($xpath_CodigoConcepto),
            Descripcion
                => $xc->findvalue($xpath_Descripcion),
            Regimen
                => $xc->findvalue($xpath_Regimen),
            PaxFijas
                => $xc->findvalue($xpath_PaxFijas),
            Paquete
                => $xc->findvalue($xpath_Paquete),
            OfertasAxB
                => $xc->findvalue($xpath_OfertasAxB),
            PaxMaximasHabitacion
                => $xc->findvalue($xpath_PaxMaximasHabitacion),
            PaxMinimas
                => $xc->findvalue($xpath_PaxMinimas),
            PaxMaximas
                => $xc->findvalue($xpath_PaxMaximas),
            Maximos3aPax
                => $xc->findvalue($xpath_Maximos3aPax),
            NinosMaximos
                => $xc->findvalue($xpath_NinosMaximos),
            LimiteEdadNinosInferior
                => $xc->findvalue($xpath_LimiteEdadNinosInferior),
            LimiteEdadNinos
                => $xc->findvalue($xpath_LimiteEdadNinos),
            EntradasNoPermitidasList
                => $xc->findvalue($xpath_EntradasNoPermitidasList),
            Acomodacion      => $self->__parse_accomodacion($node),
            Contrato         => $self->__parse_contrato($node),
            ServicioAsociado => $self->__parse_servicio_asociado($node),
        });

        push @res, $object;
    }

    return \@res;
}

sub __parse_accomodacion {
    my ($self, $dom) = @_;

    my $root = XML::LibXML::XPathContext->new($dom);
    $root->registerNs(va => 'http://tempuri.org/');

    my $xpath
        = new XML::LibXML::XPathExpression('va:AcomodacionesList/va:Acomodacion');
    my $xpath_Adultos
        = new XML::LibXML::XPathExpression('va:Adultos');
    my $xpath_Ninos
        = new XML::LibXML::XPathExpression('va:Ninos');
    my $xpath_Bebes
        = new XML::LibXML::XPathExpression('va:Bebes');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $xc = XML::LibXML::XPathContext->new($node);
        $xc->registerNs(va => 'http://tempuri.org/');

        my $object = ClubSpain::XML::Olympia::Service::Serving::Acomodation->new({
            Adultos => $xc->findvalue($xpath_Adultos),
            Ninos   => $xc->findvalue($xpath_Ninos),
            Bebes   => $xc->findvalue($xpath_Bebes),
        });

        push @res, $object;
    }

    return \@res;
}

sub __parse_contrato {
    my ($self, $dom) = @_;

    my $root = XML::LibXML::XPathContext->new($dom);
    $root->registerNs(va => 'http://tempuri.org/');

    my $xpath
        = new XML::LibXML::XPathExpression('va:ContratosList/va:Contrato');
    my $xpath_FechaInicio
        = new XML::LibXML::XPathExpression('va:FechaInicio');
    my $xpath_FechaFin
        = new XML::LibXML::XPathExpression('va:FechaFin');
    my $xpath_Precio
        = new XML::LibXML::XPathExpression('va:Precio');
    my $xpath_FechaLimiteEntrada
        = new XML::LibXML::XPathExpression('va:FechaLimiteEntrada');
    my $xpath_FechaEntradaAPartirDe
        = new XML::LibXML::XPathExpression('va:FechaEntradaAPartirDe');
    my $xpath_FechaLimiteSalida
        = new XML::LibXML::XPathExpression('va:FechaLimiteSalida');
    my $xpath_FechaSalidaAPartirDe
        = new XML::LibXML::XPathExpression('va:FechaSalidaAPartirDe');
    my $xpath_FechaLimiteReserva
        = new XML::LibXML::XPathExpression('va:FechaLimiteReserva');
    my $xpath_FechaDeReservaAPartirDe
        = new XML::LibXML::XPathExpression('va:FechaDeReservaAPartirDe');
    my $xpath_NochesMinimas
        = new XML::LibXML::XPathExpression('va:NochesMinimas');
    my $xpath_NochesMaximas
        = new XML::LibXML::XPathExpression('va:NochesMaximas');
    my $xpath_MinimoNochesCortaEstancia
        = new XML::LibXML::XPathExpression('va:MinimoNochesCortaEstancia');
    my $xpath_AntelacionMinima
        = new XML::LibXML::XPathExpression('va:AntelacionMinima');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $xc = XML::LibXML::XPathContext->new($node);
        $xc->registerNs(va => 'http://tempuri.org/');

        my $object = ClubSpain::XML::Olympia::Service::Serving::Contract->new({
            FechaInicio
                => $xc->findvalue($xpath_FechaInicio),
            FechaFin
                => $xc->findvalue($xpath_FechaFin),
            Precio
                => $xc->findvalue($xpath_Precio),
            FechaLimiteEntrada
                => $xc->findvalue($xpath_FechaLimiteEntrada),
            FechaEntradaAPartirDe
                => $xc->findvalue($xpath_FechaEntradaAPartirDe),
            FechaLimiteSalida
                => $xc->findvalue($xpath_FechaLimiteSalida),
            FechaSalidaAPartirDe
                => $xc->findvalue($xpath_FechaSalidaAPartirDe),
            FechaLimiteReserva
                => $xc->findvalue($xpath_FechaLimiteReserva),
            FechaDeReservaAPartirDe
                => $xc->findvalue($xpath_FechaDeReservaAPartirDe),
            NochesMinimas
                => $xc->findvalue($xpath_NochesMinimas),
            NochesMaximas
                => $xc->findvalue($xpath_NochesMaximas),
            MinimoNochesCortaEstancia
                => $xc->findvalue($xpath_MinimoNochesCortaEstancia),
            AntelacionMinima
                => $xc->findvalue($xpath_AntelacionMinima),
        });

        push @res, $object;
    }

    return \@res;
}

sub __parse_servicio_asociado {
    my ($self, $dom) = @_;

    my $root = XML::LibXML::XPathContext->new($dom);
    $root->registerNs(va => 'http://tempuri.org/');

    my $xpath
        = new XML::LibXML::XPathExpression('va:ServiciosAsociados/va:ServicioAsociado');
    my $xpath_CodigoServicioAsociado
        = new XML::LibXML::XPathExpression('va:CodigoServicioAsociado');
    my $xpath_CodigoConceptoServicioAsociado
        = new XML::LibXML::XPathExpression('va:CodigoConceptoServicioAsociado');
    my $xpath_DescripcionServicioAsociado
        = new XML::LibXML::XPathExpression('va:DescripcionServicioAsociado');
    my $xpath_TipoCalculoServicioAsociado
        = new XML::LibXML::XPathExpression('va:TipoCalculoServicioAsociado');
    my $xpath_PaxFijasServicioAsociado
        = new XML::LibXML::XPathExpression('va:PaxFijasServicioAsociado');
    my $xpath_PaqueteServicioAsociado
        = new XML::LibXML::XPathExpression('va:PaqueteServicioAsociado');
    my $xpath_OfertasAxB
        = new XML::LibXML::XPathExpression('va:OfertasAxB');
    my $xpath_ObligatorioServicioAsociado
        = new XML::LibXML::XPathExpression('va:ObligatorioServicioAsociado');
    my $xpath_NoAfectoAGlobalServicioAsociado
        = new XML::LibXML::XPathExpression('va:NoAfectoAGlobalServicioAsociado');
    my $xpath_LimiteEdadNinosInferiorServicioAsociado
        = new XML::LibXML::XPathExpression('va:LimiteEdadNinosInferiorServicioAsociado');
    my $xpath_LimiteEdadNinosServicioAsociado
        = new XML::LibXML::XPathExpression('va:LimiteEdadNinosServicioAsociado');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $xc = XML::LibXML::XPathContext->new($node);
        $xc->registerNs(va => 'http://tempuri.org/');

        my $object = ClubSpain::XML::Olympia::Service::Serving::ServiceAssociate->new({
            CodigoServicioAsociado
                => $xc->findvalue($xpath_CodigoServicioAsociado),
            CodigoConceptoServicioAsociado
                => $xc->findvalue($xpath_CodigoConceptoServicioAsociado),
            DescripcionServicioAsociado
                => $xc->findvalue($xpath_DescripcionServicioAsociado),
            TipoCalculoServicioAsociado
                => $xc->findvalue($xpath_TipoCalculoServicioAsociado),
            PaxFijasServicioAsociado
                => $xc->findvalue($xpath_PaxFijasServicioAsociado),
            PaqueteServicioAsociado
                => $xc->findvalue($xpath_PaqueteServicioAsociado),
            OfertasAxB
                => $xc->findvalue($xpath_OfertasAxB),
            ObligatorioServicioAsociado
                => $xc->findvalue($xpath_ObligatorioServicioAsociado),
            NoAfectoAGlobalServicioAsociado
                => $xc->findvalue($xpath_NoAfectoAGlobalServicioAsociado),
            LimiteEdadNinosInferiorServicioAsociado
                => $xc->findvalue($xpath_LimiteEdadNinosInferiorServicioAsociado),
            LimiteEdadNinosServicioAsociado
                => $xc->findvalue($xpath_LimiteEdadNinosServicioAsociado),

            ServicioAsociadoContrato => $self->__parse_servicio_asociado_contrato($node),
        });
        push @res, $object;
    }

    return \@res;
}

sub __parse_servicio_asociado_contrato {
    my ($self, $dom) = @_;

    my $root = XML::LibXML::XPathContext->new($dom);
    $root->registerNs(va => 'http://tempuri.org/');

    my $xpath
        = new XML::LibXML::XPathExpression('va:ServicioAsociadoContratosList/va:ServicioAsociadoContrato');
    my $xpath_FechaInicioServicioAsociado
        = new XML::LibXML::XPathExpression('va:FechaInicioServicioAsociado');
    my $xpath_FechaFinServicioAsociado
        = new XML::LibXML::XPathExpression('va:FechaFinServicioAsociado');
    my $xpath_PrecioServicioAsociado
        = new XML::LibXML::XPathExpression('va:PrecioServicioAsociado');
    my $xpath_FechaLimiteEntradaServicioAsociado
        = new XML::LibXML::XPathExpression('va:FechaLimiteEntradaServicioAsociado');
    my $xpath_FechaEntradaAPartirDe
        = new XML::LibXML::XPathExpression('va:FechaEntradaAPartirDe');
    my $xpath_FechaLimiteSalidaServicioAsociado
        = new XML::LibXML::XPathExpression('va:FechaLimiteSalidaServicioAsociado');
    my $xpath_FechaSalidaAPartirDe
        = new XML::LibXML::XPathExpression('va:FechaSalidaAPartirDe');
    my $xpath_FechaDeReservaAPartirDeServicioAsociado
        = new XML::LibXML::XPathExpression('va:FechaDeReservaAPartirDeServicioAsociado');
    my $xpath_FechaLimiteReservaServicioAsociado
        = new XML::LibXML::XPathExpression('va:FechaLimiteReservaServicioAsociado');
    my $xpath_NochesMinimasServicioAsociado
        = new XML::LibXML::XPathExpression('va:NochesMinimasServicioAsociado');
    my $xpath_NochesMaximasServicioAsociado
        = new XML::LibXML::XPathExpression('va:NochesMaximasServicioAsociado');
    my $xpath_MinimoNochesCortaEstanciaServicioAsociado
        = new XML::LibXML::XPathExpression('va:MinimoNochesCortaEstanciaServicioAsociado');
    my $xpath_AntelacionMinimaServicioAsociado
        = new XML::LibXML::XPathExpression('va:AntelacionMinimaServicioAsociado');

    my @res;
    my @nodes = $root->findnodes($xpath);
    foreach my $node (@nodes) {
        my $xc = XML::LibXML::XPathContext->new($node);
        $xc->registerNs(va => 'http://tempuri.org/');

        my $object = ClubSpain::XML::Olympia::Service::Serving::ServiceAssociate::Contract->new({
            FechaInicioServicioAsociado
                => $xc->findvalue($xpath_FechaInicioServicioAsociado),
            FechaFinServicioAsociado
                => $xc->findvalue($xpath_FechaFinServicioAsociado),
            PrecioServicioAsociado
                => $xc->findvalue($xpath_PrecioServicioAsociado),
            FechaLimiteEntradaServicioAsociado
                => $xc->findvalue($xpath_FechaLimiteEntradaServicioAsociado),
            FechaEntradaAPartirDe
                => $xc->findvalue($xpath_FechaEntradaAPartirDe),
            FechaLimiteSalidaServicioAsociado
                => $xc->findvalue($xpath_FechaLimiteSalidaServicioAsociado),
            FechaSalidaAPartirDe
                => $xc->findvalue($xpath_FechaSalidaAPartirDe),
            FechaDeReservaAPartirDeServicioAsociado
                => $xc->findvalue($xpath_FechaDeReservaAPartirDeServicioAsociado),
            FechaLimiteReservaServicioAsociado
                => $xc->findvalue($xpath_FechaLimiteReservaServicioAsociado),
            NochesMinimasServicioAsociado
                => $xc->findvalue($xpath_NochesMinimasServicioAsociado),
            NochesMaximasServicioAsociado
                => $xc->findvalue($xpath_NochesMaximasServicioAsociado),
            MinimoNochesCortaEstanciaServicioAsociado
                => $xc->findvalue($xpath_MinimoNochesCortaEstanciaServicioAsociado),
            AntelacionMinimaServicioAsociado
                => $xc->findvalue($xpath_AntelacionMinimaServicioAsociado),
        });

        push @res, $object;
    }

    return \@res;
}

1;
