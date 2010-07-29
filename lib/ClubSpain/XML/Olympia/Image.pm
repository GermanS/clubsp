package ClubSpain::XML::Olympia::Image;

use Moose;

has 'Codigo' => ( is => 'rw', required => 1 );
has 'Orden'  => ( is => 'rw', required => 1 );
has 'Url'    => ( is => 'rw', required => 1 );

1;
