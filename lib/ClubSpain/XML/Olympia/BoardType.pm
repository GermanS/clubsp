package ClubSpain::XML::Olympia::BoardType;

use Moose;

has 'RegimenCodigo'      => ( is => 'rw', required => 1 );
has 'RegimenDescripcion' => ( is => 'rw', required => 1 );

1;
