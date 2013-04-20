package ClubSpain::XML::VipService::Import::Response;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use ClubSpain::Model::Airline;

use Moose;

has 'tariffs' => (
    is       => 'ro',
    required => 1,
    traits   => [ 'Array' ],
    handles  => {
        all_tariffs => 'elements'
    }
);

sub store {
    my $self = shift;

    foreach my $tariffs ( $self -> all_tariffs() ) {
        $self -> save( $tariffs );
    }
}

sub save {
    my ( $self, $tariffs ) = @_;

    return unless $tariffs;

    my $airline = $self -> find_or_create_airline();
    my $board   = $self -> find_or_create_board();
    my $airport_of_departure = $self -> find_or_create_airport();
    my $airport_of_arrival   = $self -> find_or_create_airport();
    my $segment_1 = $self -> find_or_create_timetable();
    my $segment_2 = $sefl -> find_or_create_timetable();
    my $fare      = $self -> find_or_create_fare();
}

sub find_or_create_airline {
    my ( $self, $code ) = @_;

    my $airline;
    return $airline;
}

sub find_or_create_board {

}

sub find_or_create_airport {

}

sub find_or_create_timetable {

}

sub find_or_create_fare {

}


__PACKAGE__ -> meta() -> make_immutable();

1;