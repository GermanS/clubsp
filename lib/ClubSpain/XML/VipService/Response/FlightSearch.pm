package ClubSpain::XML::VipService::Response::FlightSearch;
use strict;
use warnings;
use utf8;
use namespace::autoclean;
use Moose;
use ClubSpain::XML::VipService::Response::FlightSearch::Flight;
use ClubSpain::XML::VipService::Response::FlightSearch::Price;

has 'response' => ( is => 'ro', required => 1 );
has 'flights'  => ( is => 'rw', default => sub { [] }, isa => 'ArrayRef' );

around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;
    my %args  = ( @_ == 1 ? %{ $_[0] } : @_ );

    if (exists($args{'response'})) {
        my $flights = $args{'response'}{'parameters'}{'return'}{'flights'}{'flight'};
        $args{'flights'} = [
            map ClubSpain::XML::VipService::Response::FlightSearch::Flight->new(
                %{$_},
                adult  => $args{'request'}->count_adults,
                child  => $args{'request'}->count_children,
                infant => $args{'request'}->count_infants,
            ), @$flights
        ];
    }

    return $class->$orig(%args);
};

__PACKAGE__->meta->make_immutable();

1;
