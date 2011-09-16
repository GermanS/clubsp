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

__PACKAGE__->meta->make_immutable();

1;
