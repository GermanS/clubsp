package ClubSpain::Model::Date;

use strict;
use warnings;

use Moose;

has 'id'   => (is => 'rw', required => 1);
has 'name' => (is => 'rw', required => 1);

1;
