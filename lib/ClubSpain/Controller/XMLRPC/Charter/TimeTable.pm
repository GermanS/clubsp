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

1;
