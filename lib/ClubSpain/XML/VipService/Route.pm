package ClubSpain::XML::VipService::Route;
use namespace::autoclean;
use Moose;

has 'date'      => ( is => 'ro', required => 1 );
has 'timeBegin' => ( is => 'ro', default => 0 );
has 'timeEnd'   => ( is => 'ro', default => 0 );
has 'locationBegin' => ( is => 'ro', required => 1, isa => '' );
has 'locationEnd'   => ( is => 'ro', required => 1, isa => '' );

__PACKAGE__->meta->make_immutable();

1;
