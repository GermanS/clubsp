package ClubSpain::XML::Olympia::Service;

use Moose;

has 'CodigoProveedor' => ( is => 'rw', required => 1 );
has 'Servicio'        => ( is => 'rw', isa => 'ArrayRef' );



package ClubSpain::XML::Olympia::Request::Service::Servicio;

use Moose;

has 'Codigo'                    => ( is => 'rw', required => 1 );
has 'CodigoConcepto'            => ( is => 'rw', required => 1 );
has 'Descripcion'               => ( is => 'rw', required => 1 );
has 'Regimen'                   => ( is => 'rw', required => 1 );
has 'PaxFijas'                  => ( is => 'rw', required => 1 );
has 'Paquete'                   => ( is => 'rw', required => 1 );
has 'OfertasAxB'                => ( is => 'rw', required => 1 );
has 'PaxMaximasHabitacion'      => ( is => 'rw', required => 1 );
has 'PaxMinimas'                => ( is => 'rw', required => 1 );
has 'PaxMaximas'                => ( is => 'rw', required => 1 );
has 'Maximos3aPax'              => ( is => 'rw', required => 1 );
has 'NinosMaximos'              => ( is => 'rw', required => 1 );
has 'LimiteEdadNinosInferior'   => ( is => 'rw', required => 1 );
has 'LimiteEdadNinos'           => ( is => 'rw', required => 1 );
has 'EntradasNoPermitidasList'  => ( is => 'rw', required => 1 );
has 'Acomodacion'               => ( is => 'rw', isa => 'ArrayRef' );
has 'Contrato'                  => ( is => 'rw', isa => 'ArrayRef' );
has 'ServicioAsociado'          => ( is => 'rw', isa => 'ArrayRef' );



package ClubSpain::XML::Olympia::Request::Service::Acomodacion;

use Moose;

has 'Adultos' => ( is => 'rw', required => 1 );
has 'Ninos'   => ( is => 'rw', required => 1 );
has 'Bebes'   => ( is => 'rw', required => 1 );



package ClubSpain::XML::Olympia::Request::Service::Contrato;

use Moose;

has 'FechaInicio'               => ( is => 'rw', required => 1 );
has 'FechaFin'                  => ( is => 'rw', required => 1 );
has 'Precio'                    => ( is => 'rw', required => 1 );
has 'FechaLimiteEntrada'        => ( is => 'rw', required => 1 );
has 'FechaEntradaAPartirDe'     => ( is => 'rw', required => 1 );
has 'FechaLimiteSalida'         => ( is => 'rw', required => 1 );
has 'FechaSalidaAPartirDe'      => ( is => 'rw', required => 1 );
has 'FechaLimiteReserva'        => ( is => 'rw', required => 1 );
has 'FechaDeReservaAPartirDe'   => ( is => 'rw', required => 1 );
has 'NochesMinimas'             => ( is => 'rw', required => 1 );
has 'NochesMaximas'             => ( is => 'rw', required => 1 );
has 'MinimoNochesCortaEstancia' => ( is => 'rw', required => 1 );
has 'AntelacionMinima'          => ( is => 'rw', required => 1 );

package ClubSpain::XML::Olympia::Request::Service::ServicioAsociado;

use Moose;

has 'CodigoServicioAsociado'                  => ( is => 'rw', required => 1 );
has 'CodigoConceptoServicioAsociado'          => ( is => 'rw', required => 1 );
has 'DescripcionServicioAsociado'             => ( is => 'rw', required => 1 );
has 'TipoCalculoServicioAsociado'             => ( is => 'rw', required => 1 );
has 'PaxFijasServicioAsociado'                => ( is => 'rw', required => 1 );
has 'PaqueteServicioAsociado'                 => ( is => 'rw', required => 1 );
has 'OfertasAxB'                              => ( is => 'rw', required => 1 );
has 'ObligatorioServicioAsociado'             => ( is => 'rw', required => 1 );
has 'NoAfectoAGlobalServicioAsociado'         => ( is => 'rw', required => 1 );
has 'LimiteEdadNinosInferiorServicioAsociado' => ( is => 'rw', required => 1 );
has 'LimiteEdadNinosServicioAsociado'         => ( is => 'rw', required => 1 );

has 'ServicioAsociadoContrato' => ( is => 'rw', isa => 'ArrayRef');



package ClubSpain::XML::Olympia::Request::Service::ServicioAsociado::Contrato;

use Moose;

has 'FechaInicioServicioAsociado'                 => ( is => 'rw', required => 1 );
has 'FechaFinServicioAsociado'                    => ( is => 'rw', required => 1 );
has 'PrecioServicioAsociado'                      => ( is => 'rw', required => 1 );
has 'FechaLimiteEntradaServicioAsociado'          => ( is => 'rw', required => 1 );
has 'FechaEntradaAPartirDe'                       => ( is => 'rw', required => 1 );
has 'FechaLimiteSalidaServicioAsociado'           => ( is => 'rw', required => 1 );
has 'FechaSalidaAPartirDe'                        => ( is => 'rw', required => 1 );
has 'FechaLimiteReservaServicioAsociado'          => ( is => 'rw', required => 1 );
has 'FechaDeReservaAPartirDeServicioAsociado'     => ( is => 'rw', required => 1 );
has 'NochesMinimasServicioAsociado'               => ( is => 'rw', required => 1 );
has 'NochesMaximasServicioAsociado'               => ( is => 'rw', required => 1 );
has 'MinimoNochesCortaEstanciaServicioAsociado'   => ( is => 'rw', required => 1 );
has 'AntelacionMinimaServicioAsociado'            => ( is => 'rw', required => 1 );

1;
