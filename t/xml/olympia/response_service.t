use Test::More tests =>3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::Service');
use_ok('ClubSpain::XML::Olympia::Response::Service');


my @expect = (
ClubSpain::XML::Olympia::Service->new({
    CodigoProveedor => 'CS009003',
    Servicio        => [
        map ClubSpain::XML::Olympia::Service::Serving->new($_),
        {
            Codigo          => 'B0003',
            CodigoConcepto  => '2000',
            Descripcion     => 'HAB. DBL. MEDIA PENSION',
            Regimen         => 'MP',
            PaxFijas        => '2',
            Paquete         => 'False',
            OfertasAxB      => '',
            PaxMaximasHabitacion => 3,
            PaxMinimas      => 2,
            PaxMaximas      => 2,
            Maximos3aPax    => 1,
            NinosMaximos    => 1,
            LimiteEdadNinosInferior => 2,
            LimiteEdadNinos => 12,
            EntradasNoPermitidasList => '',
            Acomodacion      => [
                map new ClubSpain::XML::Olympia::Service::Serving::Acomodation($_),
                { Adultos => 1, Ninos => 2, Bebes => 1 },
                { Adultos => 2, Ninos => 0, Bebes => 0 },
                { Adultos => 2, Ninos => 1, Bebes => 1 },
                { Adultos => 1, Ninos => 1, Bebes => 1 },
                { Adultos => 3, Ninos => 0, Bebes => 0 },
            ],
            Contrato         => [
                ClubSpain::XML::Olympia::Service::Serving::Contract->new({
                    FechaInicio                 => '01/05/2008',
                    FechaFin                    => '31/05/2008',
                    Precio                      => '28',
                    FechaLimiteEntrada          => '',
                    FechaEntradaAPartirDe       => '',
                    FechaLimiteSalida           => '',
                    FechaSalidaAPartirDe        => '',
                    FechaLimiteReserva          => '',
                    FechaDeReservaAPartirDe     => '',
                    NochesMinimas               => '5',
                    NochesMaximas               => '30',
                    MinimoNochesCortaEstancia   => '5',
                    AntelacionMinima            => '0'
                })
            ],
            ServicioAsociado => [
                map new ClubSpain::XML::Olympia::Service::Serving::ServiceAssociate($_),{
                    CodigoServicioAsociado          => 'B0008',
                    CodigoConceptoServicioAsociado  => '2059',
                    DescripcionServicioAsociado     => 'DESCUENTO 1er. NINO',
                    TipoCalculoServicioAsociado     => 'Porcentaje',
                    PaxFijasServicioAsociado        =>1,
                    PaqueteServicioAsociado         =>'False',
                    OfertasAxB                      => '',
                    ObligatorioServicioAsociado     =>'False',
                    NoAfectoAGlobalServicioAsociado =>'False',
                    LimiteEdadNinosInferiorServicioAsociado =>2,
                    LimiteEdadNinosServicioAsociado =>12,
                    ServicioAsociadoContrato => [
                        new ClubSpain::XML::Olympia::Service::Serving::ServiceAssociate::Contract({
                            FechaInicioServicioAsociado                 => '01/05/2008',
                            FechaFinServicioAsociado                    => '31/05/2008',
                            PrecioServicioAsociado                      => '-75',
                            FechaLimiteEntradaServicioAsociado          => '',
                            FechaEntradaAPartirDe                       => '',
                            FechaLimiteSalidaServicioAsociado           => '',
                            FechaSalidaAPartirDe                        => '',
                            FechaLimiteReservaServicioAsociado          => '',
                            FechaDeReservaAPartirDeServicioAsociado     => '',
                            NochesMinimasServicioAsociado               => '',
                            NochesMaximasServicioAsociado               => '',
                            MinimoNochesCortaEstanciaServicioAsociado   => '',
                            AntelacionMinimaServicioAsociado            => 0,
                        })
                    ]
                }, {
                    CodigoServicioAsociado          => 'B0010',
                    CodigoConceptoServicioAsociado  => '2065',
                    DescripcionServicioAsociado     => 'DESCUENTO 3N PERSONA',
                    TipoCalculoServicioAsociado     => 'Porcentaje',
                    PaxFijasServicioAsociado        =>1,
                    PaqueteServicioAsociado         => 'False',
                    OfertasAxB                      => '',
                    ObligatorioServicioAsociado     => 'False',
                    NoAfectoAGlobalServicioAsociado => 'False',
                    LimiteEdadNinosInferiorServicioAsociado => '',
                    LimiteEdadNinosServicioAsociado => 0,
                    ServicioAsociadoContrato => [
                        new ClubSpain::XML::Olympia::Service::Serving::ServiceAssociate::Contract({
                            FechaInicioServicioAsociado                 => '01/05/2008',
                            FechaFinServicioAsociado                    => '31/05/2008',
                            PrecioServicioAsociado                      => '-25',
                            FechaLimiteEntradaServicioAsociado          => '',
                            FechaEntradaAPartirDe                       => '',
                            FechaLimiteSalidaServicioAsociado           => '',
                            FechaSalidaAPartirDe                        => '',
                            FechaLimiteReservaServicioAsociado          => '',
                            FechaDeReservaAPartirDeServicioAsociado     => '',
                            NochesMinimasServicioAsociado               => '',
                            NochesMaximasServicioAsociado               => '',
                            MinimoNochesCortaEstanciaServicioAsociado   => '',
                            AntelacionMinimaServicioAsociado            => 0,
                        })
                    ]
                }
            ]
        },
        {
            Codigo          => 'B0006',
            CodigoConcepto  => '2001',
            Descripcion     => 'HAB. IND. MEDIA PENSION',
            Regimen         => 'MP',
            PaxFijas        => '1',
            Paquete         => 'False',
            OfertasAxB      => '',
            PaxMaximasHabitacion => 1,
            PaxMinimas      => 1,
            PaxMaximas      => 1,
            Maximos3aPax    => 0,
            NinosMaximos    => 0,
            LimiteEdadNinosInferior => 0,
            LimiteEdadNinos => 0,
            EntradasNoPermitidasList => '',
            Acomodacion      => [
                map new ClubSpain::XML::Olympia::Service::Serving::Acomodation($_),
                { Adultos => 1, Ninos => 0, Bebes => 0 }
            ],
            Contrato         => [
                ClubSpain::XML::Olympia::Service::Serving::Contract->new({
                    FechaInicio                 => '01/05/2008',
                    FechaFin                    => '31/05/2008',
                    Precio                      => '45',
                    FechaLimiteEntrada          => '',
                    FechaEntradaAPartirDe       => '',
                    FechaLimiteSalida           => '',
                    FechaSalidaAPartirDe        => '',
                    FechaLimiteReserva          => '',
                    FechaDeReservaAPartirDe     => '',
                    NochesMinimas               => '5',
                    NochesMaximas               => '30',
                    MinimoNochesCortaEstancia   => '5',
                    AntelacionMinima            => '0'
                })
            ],
            ServicioAsociado => []
        }, {
            Codigo          => 'B0053',
            CodigoConcepto  => '2000',
            Descripcion     => 'HAB CUADRUPLE MP',
            Regimen         => 'MP',
            PaxFijas        => '2',
            Paquete         => 'False',
            OfertasAxB      => '',
            PaxMaximasHabitacion => 4,
            PaxMinimas      => 2,
            PaxMaximas      => 2,
            Maximos3aPax    => 1,
            NinosMaximos    => 2,
            LimiteEdadNinosInferior => 2,
            LimiteEdadNinos => 12,
            EntradasNoPermitidasList => '',
            Acomodacion      => [
                map new ClubSpain::XML::Olympia::Service::Serving::Acomodation($_),
                { Adultos => 2, Ninos => 2, Bebes => 0 },
                { Adultos => 1, Ninos => 3, Bebes => 0 },
                { Adultos => 3, Ninos => 1, Bebes => 0 },
            ],
            Contrato         => [
                ClubSpain::XML::Olympia::Service::Serving::Contract->new({
                    FechaInicio                 => '01/05/2008',
                    FechaFin                    => '31/05/2008',
                    Precio                      => '28',
                    FechaLimiteEntrada          => '',
                    FechaEntradaAPartirDe       => '',
                    FechaLimiteSalida           => '',
                    FechaSalidaAPartirDe        => '',
                    FechaLimiteReserva          => '',
                    FechaDeReservaAPartirDe     => '',
                    NochesMinimas               => '5',
                    NochesMaximas               => '30',
                    MinimoNochesCortaEstancia   => '5',
                    AntelacionMinima            => '0'
                })
            ],
            ServicioAsociado => [
                map new ClubSpain::XML::Olympia::Service::Serving::ServiceAssociate($_), {
                    CodigoServicioAsociado          => 'B0008',
                    CodigoConceptoServicioAsociado  => '2059',
                    DescripcionServicioAsociado     => 'DESCUENTO 1er. NINO',
                    TipoCalculoServicioAsociado     => 'Porcentaje',
                    PaxFijasServicioAsociado        =>1,
                    PaqueteServicioAsociado         =>'False',
                    OfertasAxB                      => '',
                    ObligatorioServicioAsociado     =>'False',
                    NoAfectoAGlobalServicioAsociado =>'False',
                    LimiteEdadNinosInferiorServicioAsociado =>2,
                    LimiteEdadNinosServicioAsociado =>12,
                    ServicioAsociadoContrato => [
                        new ClubSpain::XML::Olympia::Service::Serving::ServiceAssociate::Contract({
                            FechaInicioServicioAsociado                 => '01/05/2008',
                            FechaFinServicioAsociado                    => '31/05/2008',
                            PrecioServicioAsociado                      => '-75',
                            FechaLimiteEntradaServicioAsociado          => '',
                            FechaEntradaAPartirDe                       => '',
                            FechaLimiteSalidaServicioAsociado           => '',
                            FechaSalidaAPartirDe                        => '',
                            FechaLimiteReservaServicioAsociado          => '',
                            FechaDeReservaAPartirDeServicioAsociado     => '',
                            NochesMinimasServicioAsociado               => '',
                            NochesMaximasServicioAsociado               => '',
                            MinimoNochesCortaEstanciaServicioAsociado   => '',
                            AntelacionMinimaServicioAsociado            => 0,
                        })
                    ]
                }, {
                    CodigoServicioAsociado          => 'B0009',
                    CodigoConceptoServicioAsociado  => '2060',
                    DescripcionServicioAsociado     => 'DESCUENTO 2N NINO',
                    TipoCalculoServicioAsociado     => 'Porcentaje',
                    PaxFijasServicioAsociado        =>1,
                    PaqueteServicioAsociado         => 'False',
                    OfertasAxB                      => '',
                    ObligatorioServicioAsociado     => 'False',
                    NoAfectoAGlobalServicioAsociado => 'False',
                    LimiteEdadNinosInferiorServicioAsociado => 2,
                    LimiteEdadNinosServicioAsociado => 12,
                    ServicioAsociadoContrato => [
                        new ClubSpain::XML::Olympia::Service::Serving::ServiceAssociate::Contract({
                            FechaInicioServicioAsociado                 => '01/05/2008',
                            FechaFinServicioAsociado                    => '31/05/2008',
                            PrecioServicioAsociado                      => '-50',
                            FechaLimiteEntradaServicioAsociado          => '',
                            FechaEntradaAPartirDe                       => '',
                            FechaLimiteSalidaServicioAsociado           => '',
                            FechaSalidaAPartirDe                        => '',
                            FechaLimiteReservaServicioAsociado          => '',
                            FechaDeReservaAPartirDeServicioAsociado     => '',
                            NochesMinimasServicioAsociado               => '',
                            NochesMaximasServicioAsociado               => '',
                            MinimoNochesCortaEstanciaServicioAsociado   => '',
                            AntelacionMinimaServicioAsociado            => 0,
                        })
                    ]
                }, {
                    CodigoServicioAsociado          => 'B0010',
                    CodigoConceptoServicioAsociado  => '2065',
                    DescripcionServicioAsociado     => 'DESCUENTO 3N PERSONA',
                    TipoCalculoServicioAsociado     => 'Porcentaje',
                    PaxFijasServicioAsociado        =>1,
                    PaqueteServicioAsociado         => 'False',
                    OfertasAxB                      => '',
                    ObligatorioServicioAsociado     => 'False',
                    NoAfectoAGlobalServicioAsociado => 'False',
                    LimiteEdadNinosInferiorServicioAsociado => '',
                    LimiteEdadNinosServicioAsociado => '',
                    ServicioAsociadoContrato => [
                        new ClubSpain::XML::Olympia::Service::Serving::ServiceAssociate::Contract({
                            FechaInicioServicioAsociado                 => '01/05/2008',
                            FechaFinServicioAsociado                    => '31/05/2008',
                            PrecioServicioAsociado                      => '-25',
                            FechaLimiteEntradaServicioAsociado          => '',
                            FechaEntradaAPartirDe                       => '',
                            FechaLimiteSalidaServicioAsociado           => '',
                            FechaSalidaAPartirDe                        => '',
                            FechaLimiteReservaServicioAsociado          => '',
                            FechaDeReservaAPartirDeServicioAsociado     => '',
                            NochesMinimasServicioAsociado               => '',
                            NochesMaximasServicioAsociado               => '',
                            MinimoNochesCortaEstanciaServicioAsociado   => '',
                            AntelacionMinimaServicioAsociado            => 0,
                        })
                    ]
                }
            ]
        }
    ]
})
);

my $response = &response();
my $result = ClubSpain::XML::Olympia::Response::Service->parse($response);

is_deeply($result, \@expect, 'check parse()');

sub response {
    return <<'';
<?xml version="1.0" encoding="ISO-8859-1"?>
<string xmlns="http://tempuri.org/">
  <Respuesta>
    <CodigoProveedor>CS009003</CodigoProveedor>
    <Servicios>
      <Servicio>
        <Codigo>B0003</Codigo>
        <CodigoConcepto>2000</CodigoConcepto>
        <Descripcion>HAB. DBL. MEDIA PENSION</Descripcion>
        <Regimen>MP</Regimen>
        <PaxFijas>2</PaxFijas>
        <Paquete>False</Paquete>
        <OfertasAxB/>
        <PaxMaximasHabitacion>3</PaxMaximasHabitacion>
        <PaxMinimas>2</PaxMinimas>
        <PaxMaximas>2</PaxMaximas>
        <Maximos3aPax>1</Maximos3aPax>
        <NinosMaximos>1</NinosMaximos>
        <LimiteEdadNinosInferior>2</LimiteEdadNinosInferior>
        <LimiteEdadNinos>12</LimiteEdadNinos>
        <AcomodacionesList>
          <Acomodacion>
            <Adultos>1</Adultos>
            <Ninos>2</Ninos>
            <Bebes>1</Bebes>
          </Acomodacion>
          <Acomodacion>
            <Adultos>2</Adultos>
            <Ninos>0</Ninos>
            <Bebes>0</Bebes>
          </Acomodacion>
          <Acomodacion>
            <Adultos>2</Adultos>
            <Ninos>1</Ninos>
            <Bebes>1</Bebes>
          </Acomodacion>
          <Acomodacion>
            <Adultos>1</Adultos>
            <Ninos>1</Ninos>
            <Bebes>1</Bebes>
          </Acomodacion>
          <Acomodacion>
            <Adultos>3</Adultos>
            <Ninos>0</Ninos>
            <Bebes>0</Bebes>
          </Acomodacion>
        </AcomodacionesList>
        <EntradasNoPermitidasList/>
        <ContratosList>
          <Contrato>
            <FechaInicio>01/05/2008</FechaInicio>
            <FechaFin>31/05/2008</FechaFin>
            <Precio>28</Precio>
            <FechaLimiteEntrada/>
            <FechaEntradaAPartirDe/>
            <FechaLimiteSalida/>
            <FechaSalidaAPartirDe/>
            <FechaLimiteReserva/>
            <FechaDeReservaAPartirDe/>
            <NochesMinimas>5</NochesMinimas>
            <NochesMaximas>30</NochesMaximas>
            <MinimoNochesCortaEstancia>5</MinimoNochesCortaEstancia>
            <AntelacionMinima>0</AntelacionMinima>
          </Contrato>
        </ContratosList>
        <ServiciosAsociados>
          <ServicioAsociado>
            <CodigoServicioAsociado>B0008</CodigoServicioAsociado>
            <CodigoConceptoServicioAsociado>2059</CodigoConceptoServicioAsociado>
            <DescripcionServicioAsociado>DESCUENTO 1er. NINO</DescripcionServicioAsociado>
            <TipoCalculoServicioAsociado>Porcentaje</TipoCalculoServicioAsociado>
            <PaxFijasServicioAsociado>1</PaxFijasServicioAsociado>
            <PaqueteServicioAsociado>False</PaqueteServicioAsociado>
            <OfertasAxB/>
            <ObligatorioServicioAsociado>False</ObligatorioServicioAsociado>
            <NoAfectoAGlobalServicioAsociado>False</NoAfectoAGlobalServicioAsociado>
            <LimiteEdadNinosInferiorServicioAsociado>2</LimiteEdadNinosInferiorServicioAsociado>
            <LimiteEdadNinosServicioAsociado>12</LimiteEdadNinosServicioAsociado>
            <ServicioAsociadoContratosList>
              <ServicioAsociadoContrato>
                <FechaInicioServicioAsociado>01/05/2008</FechaInicioServicioAsociado>
                <FechaFinServicioAsociado>31/05/2008</FechaFinServicioAsociado>
                <PrecioServicioAsociado>-75</PrecioServicioAsociado>
                <FechaLimiteEntradaServicioAsociado/>
                <FechaEntradaAPartirDe/>
                <FechaLimiteSalidaServicioAsociado/>
                <FechaSalidaAPartirDe/>
                <FechaLimiteReservaServicioAsociado/>
                <FechaDeReservaAPartirDeServicioAsociado/>
                <NochesMinimasServicioAsociado/>
                <NochesMaximasServicioAsociado/>
                <MinimoNochesCortaEstanciaServicioAsociado/>
                <AntelacionMinimaServicioAsociado>0</AntelacionMinimaServicioAsociado>
              </ServicioAsociadoContrato>
            </ServicioAsociadoContratosList>
          </ServicioAsociado>
          <ServicioAsociado>
            <CodigoServicioAsociado>B0010</CodigoServicioAsociado>
            <CodigoConceptoServicioAsociado>2065</CodigoConceptoServicioAsociado>
            <DescripcionServicioAsociado>DESCUENTO 3N PERSONA</DescripcionServicioAsociado>
            <TipoCalculoServicioAsociado>Porcentaje</TipoCalculoServicioAsociado>
            <PaxFijasServicioAsociado>1</PaxFijasServicioAsociado>
            <PaqueteServicioAsociado>False</PaqueteServicioAsociado>
            <OfertasAxB/>
            <ObligatorioServicioAsociado>False</ObligatorioServicioAsociado>
            <NoAfectoAGlobalServicioAsociado>False</NoAfectoAGlobalServicioAsociado>
            <LimiteEdadNinosInferiorServicioAsociado/>
            <LimiteEdadNinosServicioAsociado>0</LimiteEdadNinosServicioAsociado>
            <ServicioAsociadoContratosList>
              <ServicioAsociadoContrato>
                <FechaInicioServicioAsociado>01/05/2008</FechaInicioServicioAsociado>
                <FechaFinServicioAsociado>31/05/2008</FechaFinServicioAsociado>
                <PrecioServicioAsociado>-25</PrecioServicioAsociado>
                <FechaLimiteEntradaServicioAsociado/>
                <FechaEntradaAPartirDe/>
                <FechaLimiteSalidaServicioAsociado/>
                <FechaSalidaAPartirDe/>
                <FechaLimiteReservaServicioAsociado/>
                <FechaDeReservaAPartirDeServicioAsociado/>
                <NochesMinimasServicioAsociado/>
                <NochesMaximasServicioAsociado/>
                <MinimoNochesCortaEstanciaServicioAsociado/>
                <AntelacionMinimaServicioAsociado>0</AntelacionMinimaServicioAsociado>
              </ServicioAsociadoContrato>
            </ServicioAsociadoContratosList>
          </ServicioAsociado>
        </ServiciosAsociados>
      </Servicio>
      <Servicio>
        <Codigo>B0006</Codigo>
        <CodigoConcepto>2001</CodigoConcepto>
        <Descripcion>HAB. IND. MEDIA PENSION</Descripcion>
        <Regimen>MP</Regimen>
        <PaxFijas>1</PaxFijas>
        <Paquete>False</Paquete>
        <OfertasAxB/>
        <PaxMaximasHabitacion>1</PaxMaximasHabitacion>
        <PaxMinimas>1</PaxMinimas>
        <PaxMaximas>1</PaxMaximas>
        <Maximos3aPax>0</Maximos3aPax>
        <NinosMaximos>0</NinosMaximos>
        <LimiteEdadNinosInferior>0</LimiteEdadNinosInferior>
        <LimiteEdadNinos>0</LimiteEdadNinos>
        <AcomodacionesList>
          <Acomodacion>
            <Adultos>1</Adultos>
            <Ninos>0</Ninos>
            <Bebes>0</Bebes>
          </Acomodacion>
        </AcomodacionesList>
        <EntradasNoPermitidasList/>
        <ContratosList>
          <Contrato>
            <FechaInicio>01/05/2008</FechaInicio>
            <FechaFin>31/05/2008</FechaFin>
            <Precio>45</Precio>
            <FechaLimiteEntrada/>
            <FechaEntradaAPartirDe/>
            <FechaLimiteSalida/>
            <FechaSalidaAPartirDe/>
            <FechaLimiteReserva/>
            <FechaDeReservaAPartirDe/>
            <NochesMinimas>5</NochesMinimas>
            <NochesMaximas>30</NochesMaximas>
            <MinimoNochesCortaEstancia>5</MinimoNochesCortaEstancia>
            <AntelacionMinima>0</AntelacionMinima>
          </Contrato>
        </ContratosList>
      </Servicio>
      <Servicio>
        <Codigo>B0053</Codigo>
        <CodigoConcepto>2000</CodigoConcepto>
        <Descripcion>HAB CUADRUPLE MP</Descripcion>
        <Regimen>MP</Regimen>
        <PaxFijas>2</PaxFijas>
        <Paquete>False</Paquete>
        <OfertasAxB/>
        <PaxMaximasHabitacion>4</PaxMaximasHabitacion>
        <PaxMinimas>2</PaxMinimas>
        <PaxMaximas>2</PaxMaximas>
        <Maximos3aPax>1</Maximos3aPax>
        <NinosMaximos>2</NinosMaximos>
        <LimiteEdadNinosInferior>2</LimiteEdadNinosInferior>
        <LimiteEdadNinos>12</LimiteEdadNinos>
        <AcomodacionesList>
          <Acomodacion>
            <Adultos>2</Adultos>
            <Ninos>2</Ninos>
            <Bebes>0</Bebes>
          </Acomodacion>
          <Acomodacion>
            <Adultos>1</Adultos>
            <Ninos>3</Ninos>
            <Bebes>0</Bebes>
          </Acomodacion>
          <Acomodacion>
            <Adultos>3</Adultos>
            <Ninos>1</Ninos>
            <Bebes>0</Bebes>
          </Acomodacion>
        </AcomodacionesList>
        <EntradasNoPermitidasList/>
        <ContratosList>
          <Contrato>
            <FechaInicio>01/05/2008</FechaInicio>
            <FechaFin>31/05/2008</FechaFin>
            <Precio>28</Precio>
            <FechaLimiteEntrada/>
            <FechaEntradaAPartirDe/>
            <FechaLimiteSalida/>
            <FechaSalidaAPartirDe/>
            <FechaLimiteReserva/>
            <FechaDeReservaAPartirDe/>
            <NochesMinimas>5</NochesMinimas>
            <NochesMaximas>30</NochesMaximas>
            <MinimoNochesCortaEstancia>5</MinimoNochesCortaEstancia>
            <AntelacionMinima>0</AntelacionMinima>
          </Contrato>
        </ContratosList>
        <ServiciosAsociados>
          <ServicioAsociado>
            <CodigoServicioAsociado>B0008</CodigoServicioAsociado>
            <CodigoConceptoServicioAsociado>2059</CodigoConceptoServicioAsociado>
            <DescripcionServicioAsociado>DESCUENTO 1er. NINO</DescripcionServicioAsociado>
            <TipoCalculoServicioAsociado>Porcentaje</TipoCalculoServicioAsociado>
            <PaxFijasServicioAsociado>1</PaxFijasServicioAsociado>
            <PaqueteServicioAsociado>False</PaqueteServicioAsociado>
            <OfertasAxB/>
            <ObligatorioServicioAsociado>False</ObligatorioServicioAsociado>
            <NoAfectoAGlobalServicioAsociado>False</NoAfectoAGlobalServicioAsociado>
            <LimiteEdadNinosInferiorServicioAsociado>2</LimiteEdadNinosInferiorServicioAsociado>
            <LimiteEdadNinosServicioAsociado>12</LimiteEdadNinosServicioAsociado>
            <ServicioAsociadoContratosList>
              <ServicioAsociadoContrato>
                <FechaInicioServicioAsociado>01/05/2008</FechaInicioServicioAsociado>
                <FechaFinServicioAsociado>31/05/2008</FechaFinServicioAsociado>
                <PrecioServicioAsociado>-75</PrecioServicioAsociado>
                <FechaLimiteEntradaServicioAsociado/>
                <FechaEntradaAPartirDe/>
                <FechaLimiteSalidaServicioAsociado/>
                <FechaSalidaAPartirDe/>
                <FechaDeReservaAPartirDeServicioAsociado/>
                <FechaLimiteReservaServicioAsociado/>
                <NochesMinimasServicioAsociado/>
                <NochesMaximasServicioAsociado/>
                <MinimoNochesCortaEstanciaServicioAsociado/>
                <AntelacionMinimaServicioAsociado>0</AntelacionMinimaServicioAsociado>
              </ServicioAsociadoContrato>
            </ServicioAsociadoContratosList>
          </ServicioAsociado>
          <ServicioAsociado>
            <CodigoServicioAsociado>B0009</CodigoServicioAsociado>
            <CodigoConceptoServicioAsociado>2060</CodigoConceptoServicioAsociado>
            <DescripcionServicioAsociado>DESCUENTO 2N NINO</DescripcionServicioAsociado>
            <TipoCalculoServicioAsociado>Porcentaje</TipoCalculoServicioAsociado>
            <PaxFijasServicioAsociado>1</PaxFijasServicioAsociado>
            <PaqueteServicioAsociado>False</PaqueteServicioAsociado>
            <OfertasAxB/>
            <ObligatorioServicioAsociado>False</ObligatorioServicioAsociado>
            <NoAfectoAGlobalServicioAsociado>False</NoAfectoAGlobalServicioAsociado>
            <LimiteEdadNinosInferiorServicioAsociado>2</LimiteEdadNinosInferiorServicioAsociado>
            <LimiteEdadNinosServicioAsociado>12</LimiteEdadNinosServicioAsociado>
            <ServicioAsociadoContratosList>
              <ServicioAsociadoContrato>
                <FechaInicioServicioAsociado>01/05/2008</FechaInicioServicioAsociado>
                <FechaFinServicioAsociado>31/05/2008</FechaFinServicioAsociado>
                <PrecioServicioAsociado>-50</PrecioServicioAsociado>
                <FechaLimiteEntradaServicioAsociado/>
                <FechaEntradaAPartirDe/>
                <FechaLimiteSalidaServicioAsociado/>
                <FechaSalidaAPartirDe/>
                <FechaDeReservaAPartirDeServicioAsociado/>
                <FechaLimiteReservaServicioAsociado/>
                <NochesMinimasServicioAsociado/>
                <NochesMaximasServicioAsociado/>
                <MinimoNochesCortaEstanciaServicioAsociado/>
                <AntelacionMinimaServicioAsociado>0</AntelacionMinimaServicioAsociado>
              </ServicioAsociadoContrato>
            </ServicioAsociadoContratosList>
          </ServicioAsociado>
          <ServicioAsociado>
            <CodigoServicioAsociado>B0010</CodigoServicioAsociado>
            <CodigoConceptoServicioAsociado>2065</CodigoConceptoServicioAsociado>
            <DescripcionServicioAsociado>DESCUENTO 3N PERSONA</DescripcionServicioAsociado>
            <TipoCalculoServicioAsociado>Porcentaje</TipoCalculoServicioAsociado>
            <PaxFijasServicioAsociado>1</PaxFijasServicioAsociado>
            <PaqueteServicioAsociado>False</PaqueteServicioAsociado>
            <OfertasAxB/>
            <ObligatorioServicioAsociado>False</ObligatorioServicioAsociado>
            <NoAfectoAGlobalServicioAsociado>False</NoAfectoAGlobalServicioAsociado>
            <LimiteEdadNinosInferiorServicioAsociado/>
            <LimiteEdadNinosServicioAsociado/>
            <ServicioAsociadoContratosList>
              <ServicioAsociadoContrato>
                <FechaInicioServicioAsociado>01/05/2008</FechaInicioServicioAsociado>
                <FechaFinServicioAsociado>31/05/2008</FechaFinServicioAsociado>
                <PrecioServicioAsociado>-25</PrecioServicioAsociado>
                <FechaLimiteEntradaServicioAsociado/>
                <FechaEntradaAPartirDe/>
                <FechaLimiteSalidaServicioAsociado/>
                <FechaSalidaAPartirDe/>
                <FechaDeReservaAPartirDeServicioAsociado/>
                <FechaLimiteReservaServicioAsociado/>
                <NochesMinimasServicioAsociado/>
                <NochesMaximasServicioAsociado/>
                <MinimoNochesCortaEstanciaServicioAsociado/>
                <AntelacionMinimaServicioAsociado>0</AntelacionMinimaServicioAsociado>
              </ServicioAsociadoContrato>
            </ServicioAsociadoContratosList>
          </ServicioAsociado>
        </ServiciosAsociados>
      </Servicio>
    </Servicios>
  </Respuesta>
</string>


}
