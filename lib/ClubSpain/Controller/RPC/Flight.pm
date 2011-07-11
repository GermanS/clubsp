package ClubSpain::Controller::RPC::Flight;

use strict;
use warnings;
use utf8;

use base qw(Catalyst::Controller);

sub _getCountryOfDeparture : Private {
    my ($self, $c) = @_;

    my $iterator = $c->model('Country')
                     ->searchCountriesOfDeparture();

    my @res;
    while (my $item = $iterator->next) {
        push @res, { id => $item->id, name => $item->name };
    }

    return @res;
}

sub _getCityOfDeparture : Private {
    my ($self, $c, $country) = @_;

    my $iterator = $c->model('City')
                     ->searchCitiesOfDeparture(country => $country);

    my @res;
    while (my $item = $iterator->next) {
        push @res, { id => $item->id, name => $item->name };
    }

    return @res;
}

sub _getAirportOfDeparture : Private {
    my ($self, $c, $city) = @_;

    my $iterator = $c->model('Airport')
                     ->searchAirportsOfDeparture(city => $city);

    my @res;
    while (my $item = $iterator->next) {
        push @res, { id => $item->id, name => $item->name };
    }

    return @res;
}

sub _getCountryOfArrival : Private {
    my ($self, $c) = @_;

    my @res = $self->_getCountryOfDeparture($c);
    push @res, shift @res;

    return @res;
}

sub _getCityOfArrival : Private {
    my ($self, $c, $country) = @_;

    return $self->_getCityOfDeparture($c, $country);
}

sub _getAirportOfArrival : Private {
    my ($self, $c, $city) = @_;

    return $self->_getAirportOfDeparture($c, $city);
}

1;
