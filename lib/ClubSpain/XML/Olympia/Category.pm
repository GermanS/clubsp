package ClubSpain::XML::Olympia::Category;

use Moose;

has 'CodigoCategoria' => ( is => 'rw', required => 1 );
has 'NombreCategoria' => ( is => 'rw', required => 1 );

1;
