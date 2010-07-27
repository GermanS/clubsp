package ClubSpain::XML::Olympia::Language;

use Moose;

has 'Codigo'      => ( is => 'rw', required => 1 );
has 'Descripcion' => ( is => 'rw', required => 1 );

1;
