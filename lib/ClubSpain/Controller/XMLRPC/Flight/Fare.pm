package ClubSpain::Controller::XMLRPC::Flight::Fare;
use strict;
use warnings;
use utf8;
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


#TODO: попытаться удалить этот метод!!!
sub searchFlights : XMLRPC {
    my ($self, $c, $params) = @_;

    my @res = $self->_searchFlights($c,
        cityOfDeparture => $params->{'cityOfDeparture'},
        cityOfArrival   => $params->{'cityOfArrival'},
        dateOfDeparture => $params->{'dateOfDeparture'}
    );
    $c->stash(xmlrpc => \@res);
}


#поиск расписания по критерию
sub searchTimetable : XMLRPC {
    my ($self, $c, $params) = @_;

    my @res = $self->_searchTimetable($c,
        cityOfDeparture => $params->{'cityOfDeparture'},
        cityOfArrival   => $params->{'cityOfArrival'},
        dateOfDeparture => $params->{'dateOfDeparture'},
    );

    $c->stash(xmlrpc => \@res);
}


sub searchCitiesOfDepartureOW : XMLRPC {
    my ($self, $c) = @_;

    my @res = $self->_searchCitiesOfDepartureOW($c);
    $c->stash(xmlrpc => \@res);
}

sub searchCitiesOfArrivalOW : XMLRPC {
    my ($self, $c, $params) = @_;

    my @res = $self->_searchCitiesOfArrivalOW($c,
        cityOfDeparture => $params->{'cityOfDeparture'},
    );
    $c->stash(xmlrpc => \@res);
}

sub searchDatesOfDepartureOW : XMLRPC {
    my ($self, $c, $params) = @_;

    my @res = $self->_searchDatesOfDepartureOW($c,
        cityOfDeparture => $params->{'cityOfDeparture'},
        cityOfArrival   => $params->{'cityOfArrival'},
    );
    $c->stash(xmlrpc => \@res);
}

sub searchCitiesOfDeparture1RT : XMLRPC {
    my ($self, $c) = @_;

    my @res = $self->_searchCitiesOfDeparture1RT($c);
    $c->stash(xmlrpc => \@res);
}

sub searchCitiesOfArrival1RT : XMLRPC {
    my ($self, $c, $params) = @_;

    my @res = $self->_searchCitiesOfArrival1RT($c,
        cityOfDeparture1 => $params->{'cityOfDeparture1'}
    );
    $c->stash(xmlrpc => \@res);
}

sub searchCitiesOfDeparture2RT : XMLRPC {
    my ($self, $c, $params) = @_;

    my @res = $self->_searchCitiesOfDeparture2RT($c,
        cityOfDeparture1 => $params->{'cityOfDeparture1'},
        cityOfArrival1   => $params->{'cityOfArrival1'},
    );
    $c->stash(xmlrpc => \@res);
}

sub searchCitiesOfArrival2RT : XMLRPC {
    my ($self, $c, $params) = @_;

    my @res = $self->_searchCitiesOfArrival2RT($c,
        cityOfDeparture1 => $params->{'cityOfDeparture1'},
        cityOfArrival1   => $params->{'cityOfArrival1'},
        cityOfDeparture2 => $params->{'cityOfDeparture2'}
    );
    $c->stash(xmlrpc => \@res);
}

sub searchDatesOfDeparture1RT : XMLRPC {
    my ($self, $c, $params) = @_;

    my @res = $self->_searchDatesOfDeparture1RT($c,
        cityOfDeparture1 => $params->{'cityOfDeparture1'},
        cityOfArrival1   => $params->{'cityOfArrival1'},
        cityOfDeparture2 => $params->{'cityOfDeparture2'},
        cityOfArrival2   => $params->{'cityOfArrival2'},
    );
    $c->stash(xmlrpc => \@res);
}

sub searchDatesOfDeparture2RT : XMLRPC {
    my ($self, $c, $params) = @_;

    my @res = $self->_searchDatesOfDeparture2RT($c,
        cityOfDeparture1 => $params->{'cityOfDeparture1'},
        cityOfArrival1   => $params->{'cityOfArrival1'},
        cityOfDeparture2 => $params->{'cityOfDeparture2'},
        cityOfArrival2   => $params->{'cityOfArrival2'},
        dateOfDeparture1 => $params->{'dateOfDeparture1'},
    );
    $c->stash(xmlrpc => \@res);
}

1;
