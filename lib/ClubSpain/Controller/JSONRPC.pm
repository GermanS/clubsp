package ClubSpain::Controller::JSONRPC;

use strict;
use warnings;

use base qw(ClubSpain::Controller::RPC);

sub getCountryList : JSONRPCLocal {
    my ($self, $c) = @_;

    my @list = $self->_getCountryList($c);
    $c->stash(jsonrpc => \@list);
}

sub getCityList : JSONRPCLocal {
    my ($self, $c, $country) = @_;
    return unless $country;

    my @list = $self->_getCityList($c, $country);
    $c->stash(jsonrpc => \@list);
}

sub getAirportList : JSONRPCLocal {
    my ($self, $c, $city) = @_;
    return unless $city;

    my @list = $self->_getAirportList($c, $city);
    $c->stash(jsonrpc => \@list);
}

sub getTerminalList : JSONRPCLocal {
    my ($self, $c, $airport) = @_;
    return unless $airport;

    my @list = $self->_getTerminalList($c, $airport);
    $c->stash(jsonrpc => \@list);
}

sub getAirlineList : JSONRPCLocal {
    my ($self, $c) = @_;

    my @list = $self->_getAirlineList($c);
    $c->stash(jsonrpc => \@list);
}

sub getFareClassList : JSONRPCLocal {
    my ($self, $c) = @_;

    my @list = $self->_getFareClassList($c);
    $c->stash(jsonrpc => \@list);
}

1;
