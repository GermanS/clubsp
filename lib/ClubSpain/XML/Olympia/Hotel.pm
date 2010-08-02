package ClubSpain::XML::Olympia::Hotel;

use Moose;

has 'Codigo' => ( is => 'rw', required => 1 );
has 'Nombre' => ( is => 'rw', required => 1 );
has 'Direccion' => ( is => 'rw', required => 1 );
has 'Telefono' => ( is => 'rw', required => 1 );
has 'Email' => ( is => 'rw', required => 1 );
has 'Pais' => ( is => 'rw', required => 1 );
has 'NombrePais' => ( is => 'rw', required => 1 );
has 'Provincia' => ( is => 'rw', required => 1 );
has 'NombreProvincia' => ( is => 'rw', required => 1 );
has 'Poblacion' => ( is => 'rw', required => 1 );
has 'NombrePoblacion' => ( is => 'rw', required => 1 );
has 'Descripcion' => ( is => 'rw', required => 1 );
has 'Categoria' => ( is => 'rw', required => 1 );

1;
