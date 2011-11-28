package ClubSpain::XML::VipService::Response::FlightSearch::Price;
use strict;
use warnings;
use utf8;
use Moose;
use ClubSpain::XML::VipService::Response::FlightSearch::Price::Adult;
use ClubSpain::XML::VipService::Response::FlightSearch::Price::Child;
use ClubSpain::XML::VipService::Response::FlightSearch::Price::Infant;

has 'adult'  => (
    is => 'rw',
    isa => 'ArrayRef[ClubSpain::XML::VipService::Response::FlightSearch::Price::Adult]',
    default => sub { [] },
);
has 'child'  => (
    is => 'rw',
    isa => 'ArrayRef[ClubSpain::XML::VipService::Response::FlightSearch::Price::Child]',
    default => sub { [] },
);
has 'infant' => (
    is => 'rw',
    isa => 'ArrayRef[ClubSpain::XML::VipService::Response::FlightSearch::Price::Infant]',
    default => sub { [] },
);

sub initialize {
    my ($self, $price) = @_;

    foreach my $cost (@{$price}) {
        if ($cost->{'passengerType'} eq 'ADULT') {
            $self->add_adult($cost);
        } elsif ($cost->{'passengerType'} eq 'CHILD') {
            $self->add_child($cost);
        } elsif ($cost->{'passengerType'} eq 'INFANT') {
            $self->add_infant($cost);
        }
    };
}

sub add_adult {
    my ($self, $params) = @_;

    my $adult = ClubSpain::XML::VipService::Response::FlightSearch::Price::Adult->new($params);
    push @{ $self->adult }, $adult;
}

sub add_child {
    my ($self, $params) = @_;

    my $child = ClubSpain::XML::VipService::Response::FlightSearch::Price::Child->new($params);
    push @{ $self->child }, $child;
}

sub add_infant {
    my ($self, $params) = @_;

    my $infant = ClubSpain::XML::VipService::Response::FlightSearch::Price::Infant->new($params);
    push @{ $self->infant }, $infant;
}

sub total {
    my ($self, $flight) = @_;

    return
        ( $self->subtotal_adult  + $self->revenue_adult ) * $flight->adult +
        ( $self->subtotal_child  + $self->revenue_child ) * $flight->child +
        ( $self->subtotal_infant + $self->revenue_infant) * $flight->infant;
}

sub subtotal_adult {
    my $self = shift;

    my $subtotal = Math::BigFloat->new(0);
    for my $adult (@{$self->adult}) {
        $subtotal += $adult->amount();
    }

    return $subtotal;
}

sub subtotal_child {
    my $self = shift;

    my $subtotal = Math::BigFloat->new(0);
    for my $child (@{$self->child}) {
        $subtotal += $child->amount();
    }

    return $subtotal;
}

sub subtotal_infant {
    my $self = shift;

    my $subtotal = Math::BigFloat->new(0);
    for my $infant (@{$self->infant}) {
        $subtotal += $infant->amount();
    }

    return $subtotal;
}

sub revenue_adult {
    return Math::BigFloat->new(1000);
}

sub revenue_child {
    return Math::BigFloat->new(500);
}

sub revenue_infant {
    return Math::BigFloat->new(200);
}

__PACKAGE__->meta->make_immutable();

1;
