package ClubSpain::Controller::XMLRPC;

use strict;
use warnings;

use base qw(ClubSpain::Controller::RPC);

sub getCountryList : XMLRPC {
    my ($self, $c) = @_;

    my @list = $self->_getCountryList($c);
    $c->stash(xmlrpc => \@list);
}

sub getCityList : XMLRPC {
    my ($self, $c, $country) = @_;
    return unless $country;

    my @list = $self->_getCityList($c, $country);
    $c->stash(xmlrpc => \@list);
}

sub getAirportList : XMLRPC {
    my ($self, $c, $city) = @_;
    return unless $city;

    my @list = $self->_getAirportList($c, $city);
    $c->stash(xmlrpc => \@list);
}

sub getTerminalList : XMLRPC {
    my ($self, $c, $airport) = @_;
    return unless $airport;

    my @list = $self->_getTerminalList($c, $airport);
    $c->stash(xmlrpc => \@list);
}

sub getAirlineList : XMLRPC {
    my ($self, $c) = @_;

    my @list = $self->_getAirlineList($c);
    $c->stash(xmlrpc => \@list);
}

sub getFareClassList : XMLRPC {
    my ($self, $c) = @_;

    my @list = $self->_getFareClassList($c);
    $c->stash(xmlrpc => \@list);
}

1;
