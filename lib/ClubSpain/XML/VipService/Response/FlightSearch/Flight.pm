package ClubSpain::XML::VipService::Response::FlightSearch::Flight;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose;
use Math::BigFloat;
use ClubSpain::XML::VipService::Response::FlightSearch::Segment;
use ClubSpain::XML::VipService::Response::FlightSearch::Price;

has 'segments'  =>  ( is => 'ro' );
has 'price' => ( is => 'ro' );

has 'timeLimit'         => ( is => 'ro' );
has 'carrier'           => ( is => 'ro' );
has 'latinRegistration' => ( is => 'ro' );
has 'eticket'           => ( is => 'ro' );
has 'price'             => ( is => 'ro' );


around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;
    my %args  = ( @_ == 1 ? %{ $_[0] } : @_ );

    if (exists($args{'segments'})) {
        my $segments = $args{'segments'}{'segment'};
        $args{'segments'} = [
            map ClubSpain::XML::VipService::Response::FlightSearch::Segment->new(%{$_} ), @$segments
        ];
    }

    if (exists($args{'price'})) {
        my $price = $args{'price'}{'price'};
        $args{'price'} = [
            map ClubSpain::XML::VipService::Response::FlightSearch::Price->new(%{$_} ), @$price
        ];
    }

    return $class->$orig(%args);
};

sub total {
    my $self = shift;

    my $result = Math::BigFloat->new(0);
    for my $price (@{$self->price}) {
        $result += $price->amount;
    }

    return $result;
}

__PACKAGE__->meta->make_immutable();

1;
