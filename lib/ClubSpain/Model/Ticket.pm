package ClubSpain::Model::Ticket;

use strict;
use warnings;

use Moose;

has 'segment' => ( is => 'rw', isa => 'ArrayRef' );
has 'price'   => ( is => 'rw', required => 1 );

1;
