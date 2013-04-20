package ClubSpain::XML::VipService::Route;

use namespace::autoclean;
use strict;
use warnings;
use utf8;

use ClubSpain::XML::VipService::Location;

use Moose;

has 'date' => (
    is       => 'ro',
    isa      => 'DateTime',
    required => 1,
);
has 'timeBegin' => (
    is      => 'ro',
    default => sub { 0 }
);
has 'timeEnd'   => (
    is      => 'ro',
    default => sub { 0 }
);
has 'locationBegin' => (
    is       => 'ro',
    isa      => 'ClubSpain::XML::VipService::Location',
    required => 1,

);
has 'locationEnd' => (
    is       => 'ro',
    isa      => 'ClubSpain::XML::VipService::Location',
    required => 1,
);

sub to_hash {
    my $self = shift;

    return {
        date          => $self -> date -> iso8601(),
        timeBegin     => $self -> timeBegin,
        timeEnd       => $self -> timeEnd,
        locationBegin => $self -> locationBegin -> to_hash(),
        locationEnd   => $self -> locationEnd -> to_hash(),
    };
}

__PACKAGE__ -> meta() -> make_immutable();

1;

__END__