package ClubSpain::XML::Olympia::BoardTypePB;

use Moose;

has 'RegimenCodigo'   => ( is => 'rw', required => 1 );
has 'TraduccionTexto' => ( is => 'rw', required => 1 );

1;
