package ClubSpain::XML::Terramar::ProductType;

use Moose;

has 'id_tipo_articulo_clase'  => ( is => 'rw', required => 1 );
has 'id_tipo_menu'            => ( is => 'rw', required => 1 );
has 'articulo_clase'          => ( is => 'rw', required => 1 );
has 'busqueda_predeterminada' => ( is => 'rw', required => 1 );
has 'zona_predeterminada'     => ( is => 'rw', required => 1 );
has 'regimen_predeterminado'  => ( is => 'rw', required => 1 );
has 'orden'                   => ( is => 'rw', required => 1 );
has 'visible_minorista'       => ( is => 'rw', required => 1 );
has 'filtros_busqueda_diferencia_dias' => ( is => 'rw', required => 1 );

1;
