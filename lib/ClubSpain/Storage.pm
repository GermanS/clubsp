package ClubSpain::Storage;

use Moose;
use namespace::autoclean;
use MooseX::Singleton;

use ClubSpain::Schema;

has 'schema' => (
    is => 'ro',
    lazy => 1,
    default => sub { ClubSpain::Schema->connect() }
);

__PACKAGE__->meta->make_immutable();

1;
