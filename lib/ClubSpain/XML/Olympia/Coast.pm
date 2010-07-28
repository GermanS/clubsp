package ClubSpain::XML::Olympia::Coast;

use Moose;

has 'Codigo' => ( is => 'rw', required => 1 );
has 'Descripcion' => ( is => 'rw', required => 1 );

1;
