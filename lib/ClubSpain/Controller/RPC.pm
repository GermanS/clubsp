package ClubSpain::Controller::RPC;

use strict;
use warnings;
use utf8;

use base qw(Catalyst::Controller);

sub _getCountryList : Private {
    my ($self, $c) = @_;

    my $iterator = $c->model('Country')->search({ is_published => 1 });

    my @res;
    while (my $item = $iterator->next) {
        push @res, { id => $item->id, name => $item->name };
    }

    return @res;
}

sub _getCityList : Private {
    my ($self, $c, $country) = @_;

    my $iterator = $c->model('City')->search({
        country_id   => $country,
        is_published => 1,
    });

    my @res;
    while (my $item = $iterator->next) {
        push @res, { id => $item->id, name => $item->name };
    }

    return @res;
}

sub _getAirportList : Private {
    my ($self, $c, $city) = @_;

    my $iterator = $c->model('Airport')->search({
        city_id => $city,
        is_published => 1,
    });

    my @res;
    while (my $item = $iterator->next) {
        push @res, { id => $item->id, name => $item->name };
    }

    return @res;
}

sub _getTerminalList : Private {
    my ($self, $c, $airport) = @_;

    my $iterator = $c->model('Terminal')->search({
        airport_id => $airport,
        is_published => 1,
    });

    my @res;
    while (my $item = $iterator->next) {
        push @res, { id => $item->id, name => $item->name };
    }

    return @res;
}

sub _getAirlineList : Private {
    my ($self, $c) = @_;

    my $iterator = $c->model('Airline')->search({
        is_published => 1
    });

    my @res;
    while (my $item = $iterator->next) {
        push @res, { id => $item->id, name => $item->name };
    }

    return @res;
}

sub _getFareClassList : Private {
    my ($self, $c) = @_;

    my $iterator = $c->model('FareClass')->search({
        is_published => 1
    });

    my @res;
    while (my $item = $iterator->next) {
        push @res, { id => $item->id, code => $item->code, name => $item->name };
    }

    return @res;
}

sub _suggest : Private {
    my ($self, $c, $string) = @_;

    my $iterator = $c->model('City')->suggest($string);

    my @res = ();
    return @res unless $iterator;

    while (my $city = $iterator->next) {
        push @res, {
            id   => $city->id,
            iata => $city->iata,
            name => $city->name,
            name_ru => $city->name_ru,
            country => $city->country->name,
        };
    }

    return @res;
}

1;
