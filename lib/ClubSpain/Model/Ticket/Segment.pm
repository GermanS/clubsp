package ClubSpain::Model::Ticket::Segment;

use strict;
use warnings;

use Moose;

has 'departure_date'      => ( is => 'rw', required => 1 );
has 'departure_time'      => ( is => 'rw', required => 1 );
has 'departure_airport'   => ( is => 'rw', required => 1 );
has 'departure_city'      => ( is => 'rw', required => 1 );
has 'departure_country'   => ( is => 'rw', required => 1 );
has 'arrival_date'        => ( is => 'rw', required => 1 );
has 'arrival_time'        => ( is => 'rw', required => 1 );
has 'arrival_airport'     => ( is => 'rw', required => 1 );
has 'arrival_city'        => ( is => 'rw', required => 1 );
has 'arrival_country'     => ( is => 'rw', required => 1 );
has 'flight'              => ( is => 'rw', required => 1 );

1;
