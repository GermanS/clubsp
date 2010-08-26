package ClubSpain::Controller::RPC::Air;

use strict;
use warnings;

use base qw(Catalyst::Controller);

sub DepartingCountry : XMLRPC {
    my ($self, $c, @args) = @_;

    $c->stash->{'xmlrpc'} = $c->model('FlightManager')->departing_country();
}

sub DepartingCity : XMLRPC {
    my ($self, $c, @args) = @_;

    my $country = $c->request->param('departingCountry');

    $c->stash->{'xmlrpc'} = $c->model('FlightManager')->departing_city($country);
}

sub DestinationCountry : XMLRPC {
    my ($self, $c, @args) = @_;

    my $city = $c->request->param('departingCity');

    $c->stash->{'xmlrpc'} = $c->model('FlightManager')->destination_country($city);
}

sub DestinationCity : XMLRPC {
    my ($self, $c, @args) = @_;

    my $country = $c->request->param('destinationCountry');

    $c->stash->{'xmlrpc'} = $c->model('FlightManager')->destination_city($country);
}

sub DepartingDate : XMLRPC {
    my ($self, $c, @args) = @_;

    $c->stash->{'xmlrpc'} = $c->model('FlightManager')->departing_date({
        departing_city   => $c->request->param('departingCity'),
        destination_city => $c->request->param('destinationCity'),
    });
}

sub ReturningDate : XMLRPC {
    my ($self, $c, @args) = @_;

    $c->stash->{'xmlrpc'} = $c->model('Flightmanager')->returning_date({
        departing_city   => $c->request->param('departingCity'),
        destination_city => $c->request->param('destinationCity'),
        departing_date   => $c->request->param('departingDate'),
    });
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
