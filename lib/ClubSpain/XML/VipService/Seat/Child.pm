package ClubSpain::XML::VipService::Seat::Child;

use strict;
use warnings;

use Moose;
extends 'ClubSpain::XML::VipService::Seat::Base';

has 'passenger' => (
    is      => 'ro',
    default => sub { 'CHILD' },
);

__PACKAGE__ -> meta() -> make_immutable();

1;