package ClubSpain::XML::VipService::Import::Request;

use strict;
use warnings;
use utf8;
use namespace::autoclean;

use ClubSpain::XML::VipService::Config;
use ClubSpain::XML::VipService::Flight;
use ClubSpain::XML::VipService::Location;
use ClubSpain::XML::VipService::Route;
use ClubSpain::XML::VipService::Seat;
use ClubSpain::XML::VipService;

use Config::Any;
use Moose;

has 'duration' => (
    is       => 'ro',
    required => 1,
    isa      => 'ClubSpain::XML::VipService::Import::Duration'
);

sub launch {
    my $self = shift;

    my @responses;
    my $file = $self -> read_config();
    my $calc = $self -> duration;

    foreach my $dates ( $calc -> dates() ) {

        my $origin = ClubSpain::XML::VipService::Location -> new(
            code => $calc -> origin,
            name => ''
        );

        my $destination = ClubSpain::XML::VipService::Location -> new(
            code => $calc -> destination,
            name => ''
        );

        my @seat;
        push @seat, ClubSpain::XML::VipService::Seat -> new(
                passenger => 'ADULT',
                count     => 1,
        );

        my @route;
        push @route,
        ClubSpain::XML::VipService::Route -> new(
            date          => $dates -> { 'start' },
            locationBegin => $origin,
            locationEnd   => $destination,
        ),
        ClubSpain::XML::VipService::Route -> new(
            date          => $dates -> { 'end' },
            locationBegin => $destination,
            locationEnd   => $origin,
        );

        my $flight = ClubSpain::XML::VipService::Flight -> new(
            skipConnected => 'true',
            serviceClass  => 'ECONOMY',
            route         => \@route,
            seat          => \@seat
        );

        my $config  = ClubSpain::XML::VipService::Config -> new( config => $file );
        my $service = ClubSpain::XML::VipService -> new( config => $config );
        my $result  = $service -> searchFlights( $flight );

        sleep(15);

        push @responses, $result;
    }

    return @responses;
}

=head1 REMOVE THIS

=cut

sub read_config {
    my $self = shift;

    my $file = 'clubspain.conf';
    my $config = eval {
        Config::Any -> load_files({
            files   => [ $file ],
            use_ext => 1
        }) -> [0] -> { $file }
    };

    if ($@) {
        die "Could not load clubspain.conf configuration file: $@";
    }

    return $config;
}

__PACKAGE__ -> meta() -> make_immutable();

1;

__END__