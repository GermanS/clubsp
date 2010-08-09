use Test::More tests => 65;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::Service');

my $service_contrato = ClubSpain::XML::Olympia::Service::ServicioAsociado::Contrato->new({
    FechaInicioServicioAsociado                 => '01/05/2008',
    FechaFinServicioAsociado                    => '31/05/2008',
    PrecioServicioAsociado                      => '-25',
    FechaLimiteEntradaServicioAsociado          => '1',
    FechaEntradaAPartirDe                       => '2',
    FechaLimiteSalidaServicioAsociado           => '3',
    FechaSalidaAPartirDe                        => '4',
    FechaLimiteReservaServicioAsociado          => '5',
    FechaDeReservaAPartirDeServicioAsociado     => '6',
    NochesMinimasServicioAsociado               => '7',
    NochesMaximasServicioAsociado               => '8',
    MinimoNochesCortaEstanciaServicioAsociado   => '9',
    AntelacionMinimaServicioAsociado            => 0
});
isa_ok($service_contrato, 'ClubSpain::XML::Olympia::Service::ServicioAsociado::Contrato');
is($service_contrato->FechaInicioServicioAsociado,                  '01/05/2008', 'got FechaInicioServicioAsociado');
is($service_contrato->FechaFinServicioAsociado,                     '31/05/2008', 'got FechaFinServicioAsociado');
is($service_contrato->PrecioServicioAsociado,                       '-25', 'got PrecioServicioAsociado');
is($service_contrato->FechaLimiteEntradaServicioAsociado,           '1', 'got FechaLimiteEntradaServicioAsociado');
is($service_contrato->FechaEntradaAPartirDe,                        '2', 'got FechaEntradaAPartirDe');
is($service_contrato->FechaLimiteSalidaServicioAsociado,            '3', 'got FechaLimiteSalidaServicioAsociado');
is($service_contrato->FechaSalidaAPartirDe,                         '4', 'got FechaSalidaAPartirDe');
is($service_contrato->FechaLimiteReservaServicioAsociado,           '5', 'got FechaLimiteReservaServicioAsociado');
is($service_contrato->FechaDeReservaAPartirDeServicioAsociado,      '6', 'got FechaDeReservaAPartirDeServicioAsociado');
is($service_contrato->NochesMinimasServicioAsociado,                '7', 'got NochesMinimasServicioAsociado');
is($service_contrato->NochesMaximasServicioAsociado,                '8', 'got NochesMaximasServicioAsociado');
is($service_contrato->MinimoNochesCortaEstanciaServicioAsociado,    '9', 'got MinimoNochesCortaEstanciaServicioAsociado');
is($service_contrato->AntelacionMinimaServicioAsociado,             '0', 'got AntelacionMinimaServicioAsociado');

my $acociado = ClubSpain::XML::Olympia::Service::ServicioAsociado->new({
    CodigoServicioAsociado                  => 'B0010',
    CodigoConceptoServicioAsociado          => 2065,
    DescripcionServicioAsociado             => 'DESCUENTO por PERSONA',
    TipoCalculoServicioAsociado             => 'Porcentaje',
    PaxFijasServicioAsociado                => 1,
    PaqueteServicioAsociado                 => 'False',
    OfertasAxB                              => '',
    ObligatorioServicioAsociado             => 'False',
    NoAfectoAGlobalServicioAsociado         => 'False',
    LimiteEdadNinosInferiorServicioAsociado =>  '',
    LimiteEdadNinosServicioAsociado         => 0,
    ServicioAsociadoContrato                => [$service_contrato]
});
isa_ok($acociado, 'ClubSpain::XML::Olympia::Service::ServicioAsociado');
is($acociado->CodigoServicioAsociado,           'B0010', 'got CodigoServicioAsociado');
is($acociado->CodigoConceptoServicioAsociado,   '2065', 'got CodigoConceptoServicioAsociado');
is($acociado->DescripcionServicioAsociado,      'DESCUENTO por PERSONA', 'got DescripcionServicioAsociado');
is($acociado->TipoCalculoServicioAsociado,      'Porcentaje', 'got TipoCalculoServicioAsociado');
is($acociado->PaxFijasServicioAsociado,         '1', 'got PaxFijasServicioAsociado');
is($acociado->PaqueteServicioAsociado,          'False', 'got PaqueteServicioAsociado');
is($acociado->OfertasAxB,                       '', 'got OfertasAxB');
is($acociado->ObligatorioServicioAsociado,      'False', 'got ObligatorioServicioAsociado');
is($acociado->NoAfectoAGlobalServicioAsociado,  'False', 'got NoAfectoAGlobalServicioAsociado');
is($acociado->LimiteEdadNinosInferiorServicioAsociado, '', 'got LimiteEdadNinosInferiorServicioAsociado');
is($acociado->LimiteEdadNinosServicioAsociado,  '0', 'got LimiteEdadNinosServicioAsociado');
is_deeply($acociado->ServicioAsociadoContrato, [$service_contrato], 'got ServicioAsociadoContrato');



my $contrato = ClubSpain::XML::Olympia::Service::Contrato->new({
    FechaInicio               =>'01/05/2008',
    FechaFin                  =>'31/05/2008',
    Precio                    =>'28',
    FechaLimiteEntrada        => '123',
    FechaEntradaAPartirDe     => '123',
    FechaLimiteSalida         => '123',
    FechaSalidaAPartirDe      => '123',
    FechaLimiteReserva        => '123',
    FechaDeReservaAPartirDe   => '123',
    NochesMinimas             => '5',
    NochesMaximas             => '30',
    MinimoNochesCortaEstancia => '5',
    AntelacionMinima          => '0',
});
isa_ok($contrato, 'ClubSpain::XML::Olympia::Service::Contrato');
is($contrato->FechaInicio,               '01/05/2008', 'got FechaInicio');
is($contrato->FechaFin,                  '31/05/2008', 'got FechaFin');
is($contrato->Precio,                    '28', 'got Precio');
is($contrato->FechaLimiteEntrada,        '123', 'got FechaLimiteEntrada');
is($contrato->FechaEntradaAPartirDe,     '123', 'got FechaEntradaAPartirDe');
is($contrato->FechaLimiteSalida,         '123', 'got FechaLimiteSalida');
is($contrato->FechaSalidaAPartirDe,      '123', 'got FechaLimiteReserva');
is($contrato->FechaLimiteReserva,        '123', 'got FechaLimiteReserva');
is($contrato->FechaDeReservaAPartirDe,   '123', 'got FechaDeReservaAPartirDe');
is($contrato->NochesMinimas,             '5', 'got NochesMinimas');
is($contrato->NochesMaximas,             '30', 'got NochesMaximas');
is($contrato->MinimoNochesCortaEstancia, '5', 'got MinimoNochesCortaEstancia');
is($contrato->AntelacionMinima,          '0', 'got AntelacionMinima');

my $acomodacion = ClubSpain::XML::Olympia::Service::Acomodacion->new({
    Adultos => 3,
    Ninos   => 2,
    Bebes   => 1,
});
isa_ok($acomodacion, 'ClubSpain::XML::Olympia::Service::Acomodacion');
is($acomodacion->Adultos, 3, 'got adultos');
is($acomodacion->Ninos, 2, 'got ninos');
is($acomodacion->Bebes, 1, 'got bebes');

my $servicio = ClubSpain::XML::Olympia::Service::Servicio->new({
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
    Acomodacion      => [$acomodacion],
    Contrato         => [$contrato],
    ServicioAsociado => [$acociado]
});

isa_ok($servicio, 'ClubSpain::XML::Olympia::Service::Servicio');
is($servicio->Codigo, 'B0003', 'got codigo');
is($servicio->CodigoConcepto, '2000', 'got CodigoConcepto');
is($servicio->Descripcion, 'HAB. DBL. MEDIA PENSION', 'got Descripcion');
is($servicio->Regimen, 'MP', 'got Regimen');
is($servicio->PaxFijas, '2', 'got PaxFijas');
is($servicio->Paquete, 'False', 'got Paquete');
is($servicio->OfertasAxB, '', 'got OfertasAxB');
is($servicio->PaxMaximasHabitacion, 3, 'got PaxMaximasHabitacion');
is($servicio->PaxMinimas, 2, 'got PaxMinimas');
is($servicio->PaxMaximas,  2, 'got PaxMaximas');
is($servicio->Maximos3aPax, 1, 'got Maximos3aPax');
is($servicio->NinosMaximos, 1, 'got NinosMaximos');
is($servicio->LimiteEdadNinosInferior, 2, 'got LimiteEdadNinosInferior');
is($servicio->LimiteEdadNinos, 12, 'got LimiteEdadNinos');
is($servicio->EntradasNoPermitidasList, '', 'got EntradasNoPermitidasList');
is_deeply($servicio->Acomodacion, [ $acomodacion ], 'got acomodacion');


my $service = ClubSpain::XML::Olympia::Service->new({
    CodigoProveedor => 'CS009003',
    Servicio        => [ $servicio ]
});

isa_ok($service, 'ClubSpain::XML::Olympia::Service');
is($service->CodigoProveedor, 'CS009003', 'got CodigoProveedor');
