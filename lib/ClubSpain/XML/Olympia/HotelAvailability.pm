package ClubSpain::XML::Olympia::HotelAvailability;

use Moose;

has 'CodigoPeticion' => ( is => 'rw', required => 1 );
has 'hotel'          => ( is => 'rw', isa => 'ArrayRef' );

package ClubSpain::XML::Olympia::HotelAvailability::Hotel;

use Moose;

has 'Codigo'          => ( is => 'rw', required => 1 );
has 'Nombre'          => ( is => 'rw', required => 1 );
has 'CodigoPais'      => ( is => 'rw', required => 1 );
has 'CodigoProvincia' => ( is => 'rw', required => 1 );
has 'NombreProvincia' => ( is => 'rw', required => 1 );
has 'Poblacion'       => ( is => 'rw', required => 1 );
has 'Categoria'       => ( is => 'rw', required => 1 );
has 'FechaEntrada'    => ( is => 'rw', required => 1 );
has 'FechaSalida'     => ( is => 'rw', required => 1 );
has 'room'            => ( is => 'rw', isa => 'ArrayRef' );



package ClubSpain::XML::Olympia::HotelAvailability::Room;

use Moose;

has 'Habitacion'  => ( is => 'rw', required => 1 );
has 'Adultos'     => ( is => 'rw', required => 1 );
has 'ninos'       => ( is => 'rw', isa => 'ArrayRef' );
has 'numhab'      => ( is => 'rw', required => 1 );

has 'date'        => ( is => 'rw', isa => 'ArrayRef' );



package ClubSpain::XML::Olympia::HotelAvailability::Date;

use Moose;

has 'Servicio'        => ( is => 'rw', required => 1 );
has 'CodigoServicio'  => ( is => 'rw', required => 1 );
has 'CodigoConcepto'  => ( is => 'rw', required => 1 );
has 'regimen'         => ( is => 'rw', required => 1 );
has 'disponible'      => ( is => 'rw', required => 1 );
has 'precio'          => ( is => 'rw', required => 1 );

has 'option'          => ( is => 'rw', isa => 'ArrayRef' );



package ClubSpain::XML::Olympia::HotelAvailability::Option;

use Moose;

has 'Observaciones' => ( is => 'rw', required => 1 );

1;
