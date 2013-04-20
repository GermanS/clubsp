package ClubSpain::XML::VipService::Seat;

use strict;
use warnings;

use ClubSpain::XML::VipService::Seat::Adult;
use ClubSpain::XML::VipService::Seat::Child;
use ClubSpain::XML::VipService::Seat::Infant;

sub new {
    my ( $class, %params ) = @_;

    my $passenger = $params{ 'passenger' };
    my $seats     = $params{ 'count' } || 0;

    my $seat;
    if ( $class -> is_child( $passenger ) ) {
        $seat = $class -> child( $seats );
    } elsif ( $class -> is_infant( $passenger ) ) {
        $seat = $class -> infant( $seats );
    } else  {
        $seat = $class -> adult( $seats )
    }

    return $seat;
}

sub is_adult {
    my ( $class, $name ) = @_;

    return $name ~~ 'ADULT';
}

sub is_child {
    my ( $class, $name ) = @_;

    return $name ~~ 'CHILD';
}

sub is_infant {
    my ( $class, $name ) = @_;

    return $name ~~ 'INFANT';
}

sub adult {
    my ( $class, $seats ) = @_;

    return ClubSpain::XML::VipService::Seat::Adult -> new( count => $seats );
}

sub child {
    my ( $class, $seats ) = @_;

    return ClubSpain::XML::VipService::Seat::Child -> new( count => $seats );
}

sub infant {
    my ( $class, $seats ) = @_;

    return ClubSpain::XML::VipService::Seat::Infant -> new( count => $seats );
}

1;