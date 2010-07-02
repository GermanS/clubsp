package ClubSpain::XML::Terramar::ProductClassification;

use Moose;

has 'id_tipo_articulo_superclase' => (is => 'rw', required => 1);
has 'nombre' => ( is => 'rw', required => 1 );
has 'orden'  => ( is => 'rw', required => 1 );

1;
