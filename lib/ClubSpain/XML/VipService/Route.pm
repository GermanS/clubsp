package ClubSpain::XML::VipService::Route;
use namespace::autoclean;
use Moose;
use ClubSpain::XML::VipService::Location;

has 'date' => (
    is => 'ro',
    required => 1,
    isa => 'DateTime'
);
has 'timeBegin' => (
    is => 'ro',
    default => 0
);
has 'timeEnd'   => (
    is => 'ro',
    default => 0
);
has 'locationBegin' => (
    is => 'ro',
    required => 1,
    isa => 'ClubSpain::XML::VipService::Location'
);
has 'locationEnd' => (
    is => 'ro',
    required => 1,
    isa => 'ClubSpain::XML::VipService::Location'
);

sub to_hash {
    my $self = shift;

    return {
        date          => $self->date->iso8601(),
        timeBegin     => $self->timeBegin,
        timeEnd       => $self->timeEnd,
        locationBegin => $self->locationBegin->to_hash(),
        locationEnd   => $self->locationEnd->to_hash(),
    };
}

__PACKAGE__->meta->make_immutable();

1;
