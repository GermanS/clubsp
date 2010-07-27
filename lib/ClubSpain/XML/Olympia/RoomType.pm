package ClubSpain::XML::Olympia::RoomType;

use Moose;

has 'CodigoTipoHabitacion'      => ( is => 'rw', required => 1 );
has 'DescripcionTipoHabitacion' => ( is => 'rw', required => 1 );

1;
