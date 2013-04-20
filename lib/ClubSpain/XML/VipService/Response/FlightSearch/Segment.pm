package ClubSpain::XML::VipService::Response::FlightSearch::Segment;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use ClubSpain::Types;
use ClubSpain::XML::VipService::Response::FlightSearch::Airline;
use ClubSpain::XML::VipService::Response::FlightSearch::Board;
use ClubSpain::XML::VipService::Response::FlightSearch::Location;
use DateTime::Format::Strptime;
use DateTime;

use Moose;
use Moose::Util::TypeConstraints;

has 'connected'      => ( is => 'ro' );
has 'starting'       => ( is => 'ro' );
has 'bookingClass'   => ( is => 'ro' );
has 'travelDuration' => ( is => 'ro' );
has 'serviceClass'   => ( is => 'ro' );
has 'dateBegin'      => ( is => 'ro', isa => 'DateTime', coerce => 1 );
has 'dateEnd'        => ( is => 'ro', isa => 'DateTime', coerce => 1 );
has 'flightNumber'   => ( is => 'ro' );

has 'locationBegin' => ( is => 'ro' );
has 'locationEnd'   => ( is => 'ro' );
has 'airline'       => ( is => 'ro' );
has 'board'         => ( is => 'ro' );

around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;
    my %args  = ( @_ == 1 ? %{ $_[0] } : @_ );

    if ( exists( $args{ 'locationBegin' } ) ) {
        $args{ 'locationBegin' } = ClubSpain::XML::VipService::Response::FlightSearch::Location -> new(
            $args{ 'locationBegin' }
        );
    }

    if (exists($args{ 'locationEnd' })) {
        $args{ 'locationEnd' } = ClubSpain::XML::VipService::Response::FlightSearch::Location -> new(
            $args{ 'locationEnd' }
        );
    }

    if (exists($args{ 'airline' })) {
        $args{ 'airline' } = ClubSpain::XML::VipService::Response::FlightSearch::Airline -> new(
            $args{ 'airline' }
        );
    }

    if (exists($args{ 'board' })) {
        $args{ 'board' } = ClubSpain::XML::VipService::Response::FlightSearch::Board -> new(
            $args{ 'board' }
        );
    }

    return $class -> $orig( %args );
};

__PACKAGE__ -> meta() -> make_immutable();

1;

__END__