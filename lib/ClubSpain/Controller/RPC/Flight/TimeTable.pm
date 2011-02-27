package ClubSpain::Controller::RPC::Flight::TimeTable;
use strict;
use warnings;

use base qw(Catalyst::Controller);

sub _getCitiesOfDeparture {
    my ($self, $c) = @_;

    my $iterator =
        $c->model('City')->searchCitiesOfDepartureInFlight();

    my @res;
    while (my $item = $iterator->next) {
        push @res, { id => $item->id, name => $item->name };
    }

    return @res;
}

sub _getCitiesOfArrival {
    my ($self, $c, $cityOfDeparture) = @_;

    my $iterator =
        $c->model('City')
          ->searchCitiesOfArrivalInFlight(cityOfDeparture => $cityOfDeparture);

    my @res;
    while (my $item = $iterator->next) {
        push @res, { id => $item->id, name => $item->name };
    }

    return @res;
}

sub _searchFlights {
    my ($self, $c, $params) = @_;

    return
        unless $params->{'cityOfDeparture'} && $params->{'cityOfArrival'};

    my $iterator = $c->model('Flight')->searchFlights(
        cityOfDeparture => $params->{'cityOfDeparture'},
        cityOfArrival   => $params->{'cityOfArrival'},
    );

    my @res;
    while (my $item = $iterator->next) {
        my $name = sprintf "%s %s (%s - %s)",
            $item->airline->iata,
            $item->code,
            $item->departure_airport->iata,
            $item->destination_airport->iata;
        push @res, { id => $item->id, name => $name };
    }

    return @res;
}

1;
