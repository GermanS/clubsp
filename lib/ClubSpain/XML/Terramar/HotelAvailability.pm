package ClubSpain::XML::Terramar::HotelAvailability;

use Moose;

has 'fecha_desde'    => ( is => 'rw', required => 1 );
has 'fecha_hasta'    => ( is => 'rw', required => 1 );
has 'disponibilidad' => ( is => 'rw', required => 1 );

1;
