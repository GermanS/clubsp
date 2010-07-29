package ClubSpain::XML::Olympia::RoomTypePB;

use Moose;

has 'CodigoTipoHabitacion'      => ( is => 'rw', required => 1 );
has 'DescripcionTipoHabitacion' => ( is => 'rw', required => 1 );
has 'ApartamentoTipoReserva'    => ( is => 'rw', required => 1 );

1;
