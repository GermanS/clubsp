package ClubSpain::XML::Terramar::Country;

use Moose;

has 'id_zona_pais' => ( is => 'rw', required => 1 );
has 'nombre'       => ( is => 'rw', required => 1 );

1;
