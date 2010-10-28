package ClubSpain::Controller::RPC::Air;

use strict;
use warnings;

use base qw(Catalyst::Controller);

sub DepartureCountry : XMLRPC {
    my ($self, $c, @args) = @_;

    $c->stash->{'xmlrpc'} = $c->model('FlightManager')->departure_country();
}

sub DepartureCity : XMLRPC {
    my ($self, $c, @args) = @_;

    $c->stash->{'xmlrpc'} = $c->model('FlightManager')->departure_city({
        departure_country => $c->request->param('departureCountry'),
    });
}

sub ArrivalCountry : XMLRPC {
    my ($self, $c, @args) = @_;

    $c->stash->{'xmlrpc'} = $c->model('FlightManager')->arrival_country({
        departure_city => $c->request->param('departureCity')
    });
}

sub ArrivalCity : XMLRPC {
    my ($self, $c, @args) = @_;

    $c->stash->{'xmlrpc'} = $c->model('FlightManager')->arrival_city({
        arrival_country => $c->request->param('arrivalCountry')
    });
}

sub DepartureDate : XMLRPC {
    my ($self, $c, @args) = @_;

    $c->stash->{'xmlrpc'} = $c->model('FlightManager')->departure_date({
        departure_city  => $c->request->param('departureCity'),
        arrival_city    => $c->request->param('arrivalCity'),
    });
}

sub ReturnDate : XMLRPC {
    my ($self, $c, @args) = @_;

    $c->stash->{'xmlrpc'} = $c->model('Flightmanager')->return_date({
        departure_city  => $c->request->param('departureCity'),
        departure_date  => $c->request->param('departureDate'),
        arrival_city    => $c->request->param('arrivalCity'),
    });
}

sub Fare : XMLRPC {
    my ($self, $c, @args) = @_;

    $c->stash->{'xmlrpc'} = $c->model('FlightManager')->fare({
        departure_country => $c->request->param('departureCountry'),
        departure_city    => $c->request->param('departureCity'),
        departure_date    => $c->request->param('departureDate'),
        arrival_country   => $c->request->param('arrivalCountry'),
        arrival_city      => $c->request->param('arrivalCity'),
        return_date       => $c->request->param('returnDate'),
        class             => $c->request->param('class'),
        quantity          => $c->request->param('quantity'),
    });
}

sub Book : XMLRPC {
    my ($self, $c, @args) = @_;

    $c->stash->{'xmlrpc'} = {};
}

1;
