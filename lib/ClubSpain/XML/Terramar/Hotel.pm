package ClubSpain::XML::Terramar::Hotel;

use Moose;

has 'id_prestatario'   => ( is => 'rw', required => 1 );
has 'nombre_comercial' => ( is => 'rw', required => 1 );

1;
