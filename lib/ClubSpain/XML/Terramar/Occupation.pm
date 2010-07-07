package ClubSpain::XML::Terramar::Occupation;

use Moose;

has 'adultos_max'   => ( is => 'rw', required => 1 );
has 'adultos_min'   => ( is => 'rw', required => 1 );
has 'ninos_max'     => ( is => 'rw', required => 1 );
has 'pax_max'       => ( is => 'rw', required => 1 );
has 'edad_nino_max' => ( is => 'rw', required => 1 );

1;
