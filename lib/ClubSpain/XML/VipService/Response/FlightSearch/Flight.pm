package ClubSpain::XML::VipService::Response::FlightSearch::Flight;

use namespace::autoclean;
use strict;
use warnings;
use utf8;

use ClubSpain::XML::VipService::Response::FlightSearch::Price;
use ClubSpain::XML::VipService::Response::FlightSearch::Segment;
use Math::BigFloat;

use Moose;

has 'segments'  => ( is => 'ro' );
has 'price'     => ( is => 'rw', isa => 'ClubSpain::XML::VipService::Response::FlightSearch::Price' );

has 'timeLimit'         => ( is => 'ro' );
has 'carrier'           => ( is => 'ro' );
has 'latinRegistration' => ( is => 'ro' );
has 'eticket'           => ( is => 'ro' );
has 'price'             => ( is => 'ro' );

has 'adult'   => ( is => 'ro', default => sub { 1 } );
has 'child'   => ( is => 'ro', default => sub { 0 } );
has 'infant'  => ( is => 'ro', default => sub { 0 } );

around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;
    my %args  = ( @_ == 1 ? %{ $_[0] } : @_ );

    if (exists($args{ 'segments' })) {
        my $segments = $args{ 'segments' }{ 'segment' };

        $args{ 'segments' } = [
            map ClubSpain::XML::VipService::Response::FlightSearch::Segment -> new( %{$_} ), @$segments
        ];
    }

    if ( exists($args{ 'price' }) ) {
        my $price = ClubSpain::XML::VipService::Response::FlightSearch::Price -> new();
        $price -> initialize( $args{ 'price' }{ 'price' } );
        $args{ 'price' } = $price;
    }

    return $class -> $orig(%args);
};

sub total {
    my $self = shift;
    return $self -> price -> total($self);
}

__PACKAGE__  ->  meta()  ->  make_immutable();

1;

__END__