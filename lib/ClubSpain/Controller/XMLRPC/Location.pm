package ClubSpain::Controller::XMLRPC::Location;

use strict;
use warnings;
use utf8;

use base qw(ClubSpain::Controller::RPC::Location);

sub getCountryOfDeparture : XMLRPC {
    my ($self, $c) = @_;

    my @res = $self->method::next();
    $c->stash(xmlrpc => \@res);
}

sub getCityOfDeparture : XMLRPC {
    my ($self, $c, $country) = @_;
    return unless $country;

    my @res = $self->method::next($country);
    $c->stash(xmlrpc => \@res);
}

sub getAirportOfDeparture : XMLRPC {
    my ($self, $c, $city) = @_;
    return unless $city;

    my @res = $self->method::next($city);
    $c->stash(xmlrpc => \@res);
}

sub getCountryOfArrival : XMLRPC {
    my ($self, $c) = @_;

    my @res = $self->method::next();
    $c->stash(xmlrpc => \@res);
}

sub getCityOfArrival : XMLRPC {
    my ($self, $c, $country) = @_;
    return unless $country;

    my @res = $self->method::next($country);
    $c->stash(xmlrpc => \@res);
}

sub getAirportOfArrival : XMLRPC {
    my ($self, $c, $city) = @_;
    return unless $city;

    my @res = $self->method::next($city);
    $c->stash(xmlrpc => \@res);
}

1;
