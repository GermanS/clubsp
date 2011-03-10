package ClubSpain::Controller::XMLRPC::Flight::Fare;
use strict;
use warnings;
use base qw(ClubSpain::Controller::RPC::Flight::Fare);

sub searchCitiesOfDeparture : XMLRPC {
    my ($self, $c) = @_;

    my @res = $self->_searchCitiesOfDeparture($c);
    $c->stash(xmlrpc => \@res);
}

sub searchCitiesOfArrival : XMLRPC {
    my ($self, $c, $params) = @_;

    my @res = $self->_searchCitiesOfArrival($c,
        cityOfDeparture => $params->{'cityOfDeparture'}
    );
    $c->stash(xmlrpc => \@res);
}

sub searchDatesOfDeparture : XMLRPC {
    my ($self, $c, $params) = @_;

    my @res = $self->_searchDatesOfDeparture($c,
        cityOfDeparture => $params->{'cityOfDeparture'},
        cityOfArrival   => $params->{'cityOfArrival'},
        startDate       => $params->{'startDate'},
    );
    $c->stash(xmlrpc => \@res);
}

sub searchFlights : XMLRPC {
    my ($self, $c, $params) = @_;

    my @res = $self->_searchFlights($c,
        cityOfDeparture => $params->{'cityOfDeparture'},
        cityOfArrival   => $params->{'cityOfArrival'},
        dateOfDeparture => $params->{'dateOfDeparture'}
    );
    $c->stash(xmlrpc => \@res);
}

1;
