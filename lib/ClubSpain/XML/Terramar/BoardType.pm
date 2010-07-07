package ClubSpain::XML::Terramar::BoardType;

use Moose;

has 'id_tipo_suplemento' => ( is => 'rw', required => 1 );
has 'nombre' => ( is => 'rw', required => 1 );

1;
