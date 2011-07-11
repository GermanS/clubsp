package ClubSpain::Controller::XMLRPC::Flight;

use strict;
use warnings;
use utf8;

use base qw(ClubSpain::Controller::RPC::Flight);

sub getCountryOfDeparture : XMLRPC {
    my ($self, $c) = @_;

    my @res = $self->_getCountryOfDeparture($c);
    $c->stash(xmlrpc => \@res);
}

sub getCityOfDeparture : XMLRPC {
    my ($self, $c, $country) = @_;
    return unless $country;

    my @res = $self->_getCityOfDeparture($c, $country);
    $c->stash(xmlrpc => \@res);
}

sub getAirportOfDeparture : XMLRPC {
    my ($self, $c, $city) = @_;
    return unless $city;

    my @res = $self->_getAirportOfDeparture($c, $city);
    $c->stash(xmlrpc => \@res);
}

sub getCountryOfArrival : XMLRPC {
    my ($self, $c) = @_;

    my @res = $self->_getCountryOfArrival($c);
    $c->stash(xmlrpc => \@res);
}

sub getCityOfArrival : XMLRPC {
    my ($self, $c, $country) = @_;
    return unless $country;

    my @res = $self->_getCityOfArrival($c, $country);
    $c->stash(xmlrpc => \@res);
}

sub getAirportOfArrival : XMLRPC {
    my ($self, $c, $city) = @_;
    return unless $city;

    my @res = $self->_getAirportOfArrival($c, $city);
    $c->stash(xmlrpc => \@res);
}

1;
