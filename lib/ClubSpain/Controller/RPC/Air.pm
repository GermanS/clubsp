package ClubSpain::Controller::RPC::Air;

use strict;
use warnings;

use base qw(Catalyst::Controller);

sub DepartureCountry : XMLRPC {
    my ($self, $c, @args) = @_;

    my $departure = $c->model('Flightmanager')->departure_countries();

    $c->stash->{'xmlrpc'} = $departure;
}

sub ArrivalCountry : XMLRPC {
    my ($self, $c, @args) = @_;

    my $arrival = $c->model('FlightManager')->arrival_countries();

    $c->stash->{'xmlrpc'} = $arrival;
}

sub DepartureCity : XMLRPC {
    my ($self, $c, @args) = @_;

    $c->stash->{'xmlrpc'} = {};
}

sub ArrivalCity : XMLRPC {
    my ($self, $c, @args) = @_;

    $c->stash->{'xmlrpc'} = {};
}

sub DepartureDate : XMLRPC {
    my ($self, $c, @args) = @_;

    $c->stash->{'xmlrpc'} = {};
}

sub ArrivalDate : XMLRPC {
    my ($self, $c, @args) = @_;

    $c->stash->{'xmlrpc'} = {};
}

sub Fare : XMLRPC {
    my ($self, $c, @args) = @_;

    $c->stash->{'xmlrpc'} = {};
}

sub Book : XMLRPC {
    my ($self, $c, @args) = @_;

    $c->stash->{'xmlrpc'} = {};
}

1;
