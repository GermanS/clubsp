package ClubSpain::XML::VipService::Seat::Infant;

use strict;
use warnings;

use Moose;
extends 'ClubSpain::XML::VipService::Seat::Base';

has 'passenger' => (
    is      => 'ro',
    default => sub { 'INFANT' },
);

__PACKAGE__ -> meta() -> make_immutable();

1;