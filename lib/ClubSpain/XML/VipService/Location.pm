package ClubSpain::XML::VipService::Location;
use namespace::autoclean;
use Moose;

has 'code' => ( is => 'ro', required => 1 );
has 'name' => ( is => 'ro', required => 1 );

sub to_hash {
    my $self = shift;
    return { code => $self->code, name => $self->name };
}

__PACKAGE__->meta->make_immutable();

1;
