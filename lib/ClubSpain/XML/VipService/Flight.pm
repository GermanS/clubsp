package ClubSpain::XML::VipService::Flight;

use strict;
use warnings;
use namespace::autoclean;

use Moose;
use Moose::Util::TypeConstraints;

enum 'Boolean', [qw(true false)];
enum 'ClassOfService', [qw(ECONOMY BUSINESS)];

has 'eticketsOnly'  => ( is => 'ro', default => 'true',    isa => 'Boolean' );
has 'mixedVendors'  => ( is => 'ro', default => 'true',    isa => 'Boolean' );
has 'skipConnected' => ( is => 'ro', default => 'false',   isa => 'Boolean' );
has 'serviceClass'  => ( is => 'ro', default => 'ECONOMY', isa => 'ClassOfService' );

has 'route' => (
    is      => 'rw',
    traits  =>  [ 'Array' ],
    default => sub { [] },
    handles => {
        add_route  => 'push',
        has_routes => 'count',
        map_routes => 'map',
    }
);
has 'seat'  => (
    is      => 'rw',
    traits  => [ 'Array' ],
    default => sub { [] },
    handles => {
        add_seat  => 'push',
        has_seats => 'count',
        map_seats => 'map',
    }
);

sub to_hash {
    my $self = shift;

    my @route = ();
    push @route, $_ -> to_hash() for (@{$self -> route});

    my @seat = ();
    push @seat, $_ -> to_hash() for (@{$self -> seat});

    return {
        eticketsOnly  => $self -> eticketsOnly,
        mixedVendors  => $self -> mixedVendors,
        skipConnected => $self -> skipConnected,
        serviceClass  => $self -> serviceClass,
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

    foreach my $seat ( @{$self -> seat} ) {
        return $seat -> count if $seat -> is_adult();
    }

    return;
}

sub count_children {
    my $self = shift;

    foreach my $seat ( @{$self -> seat} ) {
        return $seat -> count if $seat -> is_child();
    }

    return;
}

sub count_infants {
    my $self = shift;

    foreach my $seat ( @{$self -> seat} ) {
        return $seat -> count if $seat -> is_infant();
    }

    return;
}

__PACKAGE__ -> meta() -> make_immutable();

1;