package ClubSpain::XML::Olympia::City;

use Moose;

has 'Pais_Codigo'      => ( is => 'rw', required => 1 );
has 'Provincia_Codigo' => ( is => 'rw', required => 1 );
has 'Poblacion_Codigo' => ( is => 'rw', required => 1 );
has 'Poblacion_Nombre' => ( is => 'rw', required => 1 );

1;
