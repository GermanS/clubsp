package ClubSpain::Controller::RPC::Charter::TimeTable;
use strict;
use warnings;
use utf8;
use base qw(Catalyst::Controller);

sub getCitiesOfDeparture {
    my $self = shift;

    my $iterator = $self->_app->model('City')->searchCitiesOfDepartureInFlight();
    return $self->formatter($iterator);
}

sub getCitiesOfArrival {
    my ($self, $cityOfDeparture) = @_;

    my $iterator = $self->_app
                        ->model('City')
                        ->searchCitiesOfArrivalInFlight(cityOfDeparture => $cityOfDeparture);
    return $self->formatter($iterator);
}

sub searchFlights {
    my ($self, $params) = @_;

    return
        unless $params->{'cityOfDeparture'} && $params->{'cityOfArrival'};

    my $iterator = $self->_app->model('Flight')->searchFlights(
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

sub formatter {
    my ($self, $iterator) = @_;

    my @res;
    while (my $item = $iterator->next) {
        push @res, { id => $item->id, name => $item->name };
    }

    return @res;
}

1;
