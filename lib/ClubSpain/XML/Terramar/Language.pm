package ClubSpain::XML::Terramar::Language;

use Moose;

has 'id_idioma'     => ( is => 'rw', required => 1 );
has 'nombre_idioma' => ( is => 'rw', required => 1 );
has 'logo_idioma'   => ( is => 'rw', required => 1 );

1;
