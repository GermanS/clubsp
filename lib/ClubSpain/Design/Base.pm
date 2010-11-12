package ClubSpain::Design::Base;

use Moose;
use namespace::autoclean;

use ClubSpain::Storage;

sub schema {
    return ClubSpain::Storage->instance()->schema();
}

sub delete {
    my ($self, $id) = @_;

    return $self->fetch_by_id($id)->delete();
}

__PACKAGE__->meta->make_immutable();

1;
