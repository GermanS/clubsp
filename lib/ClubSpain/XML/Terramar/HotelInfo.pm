package ClubSpain::XML::Terramar::HotelInfo;

use Moose;

has 'nif'                   => (is => 'rw', required =>  1);
has 'nombre_comercial'      => (is => 'rw', required =>  1);
has 'descripcion'           => (is => 'rw', required =>  1);

has 'direccion'             => (is => 'rw', required =>  1);
has 'poblacion'             => (is => 'rw', required =>  1);
has 'provincia'             => (is => 'rw', required =>  1);
has 'telefono'              => (is => 'rw', required =>  1);
has 'fax'                   => (is => 'rw', required =>  1);
has 'email'                 => (is => 'rw', required =>  1);
has 'url'                   => (is => 'rw', required =>  1);
has 'categoria'             => (is => 'rw', required =>  1);
has 'linea_bono_1'          => (is => 'rw', required =>  1);
has 'linea_bono_2'          => (is => 'rw', required =>  1);
has 'linea_bono_3'          => (is => 'rw', required =>  1);
has 'articulos_asociados'   => (is => 'rw', required =>  1);
has 'longitud'              => (is => 'rw', required =>  1);
has 'latitud'               => (is => 'rw', required =>  1);
has 'codigo_postal'         => (is => 'rw', required =>  1);

has 'caracteristica'       => ( is => 'rw', isa => 'ArrayRef' );
has 'imagen'                => ( is => 'rw', isa => 'ArrayRef' );

package ClubSpain::XML::Terramar::HotelInfo::Image;

use Moose;

has 'name' => (is => 'rw', required =>  1);


package ClubSpain::XML::Terramar::HotelInfo::Caracteristica;

use Moose;

has 'categoria'         => (is => 'rw', required =>  1);
has 'subcategoria'      => (is => 'rw', required =>  1);
has 'nombre'            => (is => 'rw', required =>  1);
has 'valor'             => (is => 'rw', required =>  1);
has 'id_caracteristica' => (is => 'rw', required =>  1);
has 'id_subcategoria'   => (is => 'rw', required =>  1);

1;
