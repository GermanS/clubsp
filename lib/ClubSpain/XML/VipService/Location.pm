package ClubSpain::XML::VipService::Location;
use namespace::autoclean;
use Moose;

has 'code' => ( is => 'ro', required => 1 );
has 'name' => ( is => 'ro', required => 1 );

__PACKAGE__->meta->make_immutable();

1;
