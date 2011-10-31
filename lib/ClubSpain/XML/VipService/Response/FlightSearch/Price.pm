package ClubSpain::XML::VipService::Response::FlightSearch::Price;
use strict;
use warnings;
use utf8;
use Moose;

has 'amount'        => ( is => 'ro' );
has 'elementType'   => ( is => 'ro' );
has 'passengerType' => ( is => 'ro' );

__PACKAGE__->meta->make_immutable();

1;
