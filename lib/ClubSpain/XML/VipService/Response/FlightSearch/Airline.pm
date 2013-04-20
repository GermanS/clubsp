package ClubSpain::XML::VipService::Response::FlightSearch::Airline;

use namespace::autoclean;
use strict;
use warnings;
use utf8;

use Moose;

has 'code' => ( is => 'ro' );
has 'name' => ( is => 'ro' );

__PACKAGE__-> meta() -> make_immutable();

1;

__END__