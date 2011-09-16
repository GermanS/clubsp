package ClubSpain::XML::VipService::Seat;
use namespace::autoclean;
use Moose;
use Moose::Util::TypeConstraints;

enum 'PassengerType', [qw(ADULT CHILD INFANT)];

has 'passenger' => (
    is      => 'ro',
    default => 'ADULT',
    isa     => 'PassengerType'
);
has 'count' => (
    is       => 'ro',
    required => 1,
    default  => 0,
);

sub to_hash {
    my $self = shift;

    return {
        count         => $self->count,
        passengerType => $self->passenger
    };
}

__PACKAGE__->meta->make_immutable();

1;
