package ClubSpain::XML::VipService::Seat::Adult;

use strict;
use warnings;

use Moose;
extends 'ClubSpain::XML::VipService::Seat::Base';

has 'passenger' => (
    is      => 'ro',
    default => sub { 'ADULT' },
);

__PACKAGE__ -> meta() -> make_immutable();

1;