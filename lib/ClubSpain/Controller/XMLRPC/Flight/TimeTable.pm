package ClubSpain::Controller::XMLRPC::Flight::TimeTable;
use strict;
use warnings;
use utf8;
use base qw(ClubSpain::Controller::RPC::Flight::TimeTable);

sub getCitiesOfDeparture : XMLRPC {
    my ($self, $c) = @_;

    my @res = $self->_getCitiesOfDeparture($c);
    $c->stash(xmlrpc => \@res);
}

sub getCitiesOfArrival : XMLRPC {
    my ($self, $c, $cityOfDeparture) = @_;

    my @res = $self->_getCitiesOfArrival($c, $cityOfDeparture);
    $c->stash(xmlrpc => \@res);
}

sub searchFlights : XMLRPC {
    my ($self, $c, $params) = @_;

    my @res = $self->_searchFlights($c, $params);
    $c->stash(xmlrpc => \@res);
}

1;
