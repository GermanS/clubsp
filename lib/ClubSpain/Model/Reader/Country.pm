package ClubSpain::Model::Reader::Country;
use Moose;
use namespace::autoclean;

has 'resultset' => ( is => 'ro', required => 1);

sub read {
    my $self = shift;

    my @res;
    my $iterator = $self->resultset;
    while (my $item = $iterator->next) {
        push @res, { id => $item->id, name => $item->name };
    }

    return \@res;
}

__PACKAGE__->meta->make_immutable();

1;
