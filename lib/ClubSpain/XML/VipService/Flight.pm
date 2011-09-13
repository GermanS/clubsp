package ClubSpain::XML::VipService::Flight;
use namespace::autoclean;
use Moose;
use Moose::Util::TypeConstraints;

enum 'Boolean', [qw(true false)];
enum 'ClassOfService', [qw(ECONOMY BUSINESS FIRST PREMIUM)];

has 'route' => ( is => 'ro', isa => 'ArrayRef' );

has 'eticketsOnly'  => ( is => 'ro', default => 'true', isa => 'Boolean' );
has 'mixedVendors'  => ( is => 'ro', default => 'true', isa => 'Boolean' );
has 'skipConnected' => ( is => 'ro', default => 'true', isa => 'Boolean' );
has 'serviceClass'  => ( is => 'ro', default => 'ECONOMY', isa => 'ClassOfService' );

__PACKAGE__->meta->make_immutable();

1;
