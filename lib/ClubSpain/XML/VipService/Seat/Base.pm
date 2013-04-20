package ClubSpain::XML::VipService::Seat::Base;

use strict;
use warnings;
use namespace::autoclean;

use Moose;

has 'count' => (
    is       => 'ro',
    isa      => 'Int',
    default  => sub { 0 },
    required => 1,
);

sub passenger { die "override me!" }

sub to_hash {
    my $self = shift;

    return {
        count         => $self -> count(),
        passengerType => $self -> passenger()
    };
}

sub is_adult {
    my $self = shift;

    return $self -> passenger eq 'ADULT';
}

sub is_child {
    my $self = shift;

    return $self -> passenger eq 'CHILD';
}

sub is_infant {
    my $self = shift;

    return $self -> passenger eq 'INFANT';
}

__PACKAGE__ -> meta() -> make_immutable();

1;