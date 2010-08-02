package ClubSpain::XML::Olympia::Pictogram;

use Moose;

has 'Codigo'      => ( is => 'rw', required => 1 );
has 'Descripcion' => ( is => 'rw', required => 1 );
has 'Url'         => ( is => 'rw', required => 1 );

1;
