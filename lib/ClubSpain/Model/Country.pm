package ClubSpain::Model::Country;

use strict;
use warnings;

use Moose;

has 'code' => ( is => 'rw', required => 1 );
has 'name' => ( is => 'rw', required => 1 );

1;
