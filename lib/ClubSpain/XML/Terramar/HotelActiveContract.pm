package ClubSpain::XML::Terramar::HotelActiveContract;

use Moose;

has 'id'                          => ( is => 'rw', required => 1 );
has 'nombre'                      => ( is => 'rw', required => 1 );
has 'id_tipo_articulo_clase'      => ( is => 'rw', required => 1 );
has 'id_tipo_articulo_superclase' => ( is => 'rw', required => 1 );
has 'id_zona_pais'                => ( is => 'rw', required => 1 );
has 'id_zona'                     => ( is => 'rw', required => 1 );

1;
