package ClubSpain::XML::VipService::Flight;
use namespace::autoclean;
use Moose;
use Moose::Util::TypeConstraints;

enum 'Boolean', [qw(true false)];
enum 'ClassOfService', [qw(ECONOMY BUSINESS)];

has 'route' => ( is => 'ro', isa => 'ArrayRef' );
has 'seat'  => ( is => 'ro', isa => 'ArrayRef' );

has 'eticketsOnly'  => ( is => 'ro', default => 'true', isa => 'Boolean' );
has 'mixedVendors'  => ( is => 'ro', default => 'true', isa => 'Boolean' );
has 'skipConnected' => ( is => 'ro', default => 'false', isa => 'Boolean' );
has 'serviceClass'  => ( is => 'ro', default => 'ECONOMY', isa => 'ClassOfService' );

sub to_hash {
    my $self = shift;

    my @route = ();
    push @route, $_->to_hash() for (@{$self->route});

    my @seat = ();
    push @seat, $_->to_hash() for (@{$self->seat});

    return {
        eticketsOnly  => $self->eticketsOnly,
        mixedVendors  => $self->mixedVendors,
        skipConnected => $self->skipConnected,
        serviceClass  => $self->serviceClass,
        route => {
            segment => \@route
        },
        seats => {
            seatPreferences => \@seat
        },
    };
}

sub count_adults {
    my $self = shift;

    foreach my $seat ( @{$self->seat} ) {
        return $seat->count if $seat->is_adult();
    }

    return 0;
}

sub count_children {
    my $self = shift;

    foreach my $seat ( @{$self->seat} ) {
        return $seat->count if $seat->is_child();
    }

    return 0;
}

sub count_infants {
    my $self = shift;

    foreach my $seat ( @{$self->seat} ) {
        return $seat->count if $seat->is_infant();
    }

    return 0;
}

__PACKAGE__->meta->make_immutable();

1;
