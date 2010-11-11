package ClubSpain::Design::Base;

use Moose;
use namespace::autoclean;

use ClubSpain::Storage;

sub schema {
    return ClubSpain::Storage->instance()->schema();
}

__PACKAGE__->meta->make_immutable();

1;
