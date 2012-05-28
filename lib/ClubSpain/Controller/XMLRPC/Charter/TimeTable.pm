package ClubSpain::Controller::XMLRPC::Charter::TimeTable;
use strict;
use warnings;
use utf8;
use base qw(ClubSpain::Controller::RPC::Charter::TimeTable);

sub getCitiesOfDeparture : XMLRPC {
    my ($self, $c) = @_;

    my @res = $self->next::method();
    $c->stash(xmlrpc => \@res);
}

sub getCitiesOfArrival : XMLRPC {
    my ($self, $c, $cityOfDeparture) = @_;

    my @res = $self->next::method($cityOfDeparture);
    $c->stash(xmlrpc => \@res);
}

sub searchFlights : XMLRPC {
    my ($self, $c, $params) = @_;

    my @res = $self->next::method($params);
    $c->stash(xmlrpc => \@res);
}

#передача городов отправления с внешним источникам
sub findCitiesOfDeparture :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method();
    $c->stash(json_data => \@res);
}

#передача городов прибытия с внешним источникам
sub findCitiesOfArrival :Local {
    my ($self, $c, %params) = @_;

    my @res = $self->next::method(
        cityOfDeparture => $params{'cityOfDeparture'}
    );
    $c->stash(json_data => \@res);
}

#передача дат внешним источникам
sub findDatesOfDeparture :Local {
    my ($self, $c, %params) = @_;

    my @res = $self->next::method(
        cityOfDeparture => $params{'cityOfDeparture'},
        cityOfArrival   => $params{'cityOfArrival'}
    );
    $c->stash(json_data => \@res);
}

#передача расписания внешним источникам
sub findFlights :Local {
    my ($self, $c, %params) = @_;

    my @res = $self->next::method(
        cityOfDeparture => $params{'cityOfDeparture'},
        cityOfArrival   => $params{'cityOfArrival'},
        dateOfDeparture => $params{'dateOfDeparture'}
    );
    $c->stash(json_data => \@res);
}

1;
