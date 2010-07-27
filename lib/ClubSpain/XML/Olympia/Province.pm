package ClubSpain::XML::Olympia::Province;

use Moose;

has 'Pais_Codigo'      => ( is => 'rw', required => 1 );
has 'Provincia_Codigo' => ( is => 'rw', required => 1 );
has 'Provincia_Nombre' => ( is => 'rw', required => 1 );

1;
