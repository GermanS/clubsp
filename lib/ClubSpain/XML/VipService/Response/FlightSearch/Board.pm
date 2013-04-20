package ClubSpain::XML::VipService::Response::FlightSearch::Board;

use namespace::autoclean;
use strict;
use warnings;
use utf8;

use Moose;

has 'name' => ( is => 'ro' );
has 'code' => ( is => 'ro' );

__PACKAGE__ -> meta -> make_immutable();

1;

__END__