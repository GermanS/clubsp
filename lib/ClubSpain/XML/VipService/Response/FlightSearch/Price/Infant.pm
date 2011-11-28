package ClubSpain::XML::VipService::Response::FlightSearch::Price::Infant;
use strict;
use warnings;
use utf8;
use Moose;

has 'amount'      => ( is => 'rw' );
has 'elementType' => ( is => 'ro' );

__PACKAGE__->meta->make_immutable();

1;