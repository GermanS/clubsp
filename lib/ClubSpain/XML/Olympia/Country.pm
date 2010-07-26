package ClubSpain::XML::Olympia::Country;

use Moose;

has 'Codigo_Pais' => ( is => 'rw', required => 1 );
has 'Nombre_pais' => ( is => 'rw', required => 1 );

1;
