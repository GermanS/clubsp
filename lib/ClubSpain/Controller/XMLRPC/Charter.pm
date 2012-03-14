package ClubSpain::Controller::XMLRPC::Charter;
use strict;
use warnings;
use utf8;
use base qw(ClubSpain::Controller::RPC::Charter);


#поиск городов отрпавления для тарифов в одну сторону
sub searchCitiesOfDepartureOW :XMLRPC {
    my ($self, $c) = @_;

    my @res = $self->next::method();
    $c->stash(xmlrpc => \@res);
}


#поиск городов прибытия для тарифов в одну сторону
sub searchCitiesOfArrivalOW :XMLRPC {
    my ($self, $c, %params) = @_;

    my @res = $self->next::method(
        cityOfDeparture => $params{'cityOfDeparture'},
    );

    $c->stash(xmlrpc => \@res);
}


#поиск дат для тарифов в одну сторону
sub searchDatesOfDepartureOW :XMLRPC {
    my ($self, $c, %params) = @_;

    my @res = $self->next::method(
        cityOfDeparture => $params{'cityOfDeparture'},
        cityOfArrival   => $params{'cityOfArrival'}
    );

    $c->stash(xmlrpc => \@res);
}


#поиск городов отправления в первом сегменте для тарифов туда и обратно
sub searchCitiesOfDeparture1RT :XMLRPC {
    my ($self, $c) = @_;

    my @res = $self->next::method();
    $c->stash(xmlrpc => \@res);
}


#поиск городов прибытия в первом сегменте для тарифов туда и обратно
sub searchCitiesOfArrival1RT :XMLRPC {
    my ($self, $c, %params) = @_;

    my @res = $self->next::method(
        cityOfDeparture1 => $params{'cityOfDeparture1'}
    );

    $c->stash(xmlrpc => \@res);
}


#поиск городов отправления во втором сегменте для тарифов туда и обратно
sub searchCitiesOfDeparture2RT :XMLRPC {
    my ($self, $c, %params) = @_;

    my @res = $self->next::method(
        cityOfDeparture1 => $params{'cityOfDeparture1'},
        cityOfArrival1   => $params{'cityOfArrival1'}
    );

    $c->stash(xmlrpc => \@res);
}


#поиск городов прибытия во втором сегменте для тарифов туда и обратно
sub searchCitiesOfArrival2RT :XMLRPC {
    my ($self, $c, %params) = @_;

    my @res = $self->next::method(
        cityOfDeparture1 => $params{'cityOfDeparture1'},
        cityOfArrival1   => $params{'cityOfArrival1'},
        cityOfDeparture2 => $params{'cityOfDeparture2'}
    );

    $c->stash(xmlrpc => \@res);
}


#поиск дат первого сегмента для тарифов туда и обратно
sub searchDatesOfDeparture1RT :XMLRPC {
    my ($self, $c, %params) = @_;

    my @res = $self->next::method(
        cityOfDeparture1 => $params{'cityOfDeparture1'},
        cityOfArrival1   => $params{'cityOfArrival1'},
        cityOfDeparture2 => $params{'cityOfDeparture2'},
        cityOfArrival2   => $params{'cityOfArrival2'}
    );

    $c->stash(xmlrpc => \@res);
}


#поиск дат второго сегмента для тарифов туда и обратно
sub searchDatesOfDeparture2RT :XMLRPC {
    my ($self, $c, %params) = @_;

    my @res = $self->next::method(
        cityOfDeparture1 => $params{'cityOfDeparture1'},
        cityOfArrival1   => $params{'cityOfArrival1'},
        cityOfDeparture2 => $params{'cityOfDeparture2'},
        cityOfArrival2   => $params{'cityOfArrival2'},
        dateOfDeparture1 => $params{'dateOfDeparture1'},
    );

    $c->stash(xmlrpc => \@res);
}


#поиск тарифов в обе стороны по заданным критериям
sub searchRT :XMLRPC {
    my ($self, $c, %params) = @_;

    my @res = $self->next::method({
            cityOfDeparture => $params{'cityOfDeparture1'},
            cityOfArrival   => $params{'cityOfArrival1'},
            dateOfDeparture => $params{'dateOfDeparture1'},
        }, {
            cityOfDeparture => $params{'cityOfDeparture2'},
            cityOfArrival   => $params{'cityOfArrival2'},
            dateOfDeparture => $params{'dateOfDeparture2'},
    });

    $c->stash(xmlrpc => \@res);
}


#поиск тарифа в одну сторону
sub searchOW :XMLRPC {
    my ($self, $c, %params) = @_;

    my @res = $self->next::method(
        cityOfDeparture => $params{'cityOfDeparture'},
        cityOfArrival   => $params{'cityOfArrival'},
        dateOfDeparture => $params{'dateOfDeparture'},
    );

    $c->stash(xmlrpc => \@res);
}


#Поиск всех тарифов RT по заданным городам
sub viewRT :XMLRPC {
    my ($self, $c, %params) = @_;

    my @res = $self->next::method({
            cityOfDeparture => $params{'cityOfDeparture1'},
            cityOfArrival   => $params{'cityOfArrival1'},
        }, {
            cityOfDeparture => $params{'cityOfDeparture2'},
            cityOfArrival   => $params{'cityOfArrival2'},
    });

    $c->stash(xmlrpc => \@res);
}


#Поиск всех тарифов в одну сторону
sub viewOW :XMLRPC {
    my ($self, $c, %params) = @_;

    my @res = $self->next::method(
        cityOfDeparture => $params{'cityOfDeparture'},
        cityOfArrival   => $params{'cityOfArrival'}
    );

    $c->stash(xmlrpc => \@res);
}
#
#
#
#внутренний метод поиска городов отправления
sub searchCitiesOfDeparture :XMLRPC {
    my ($self, $c) = @_;

    my @res = $self->next::method();
    $c->stash(xmlrpc => \@res);
}


#внутренний метод поиска городов прибытия
sub searchCitiesOfArrival :XMLRPC {
    my ($self, $c, $params) = @_;

    my @res = $self->next::method(
        cityOfDeparture => $params->{'cityOfDeparture'}
    );

    $c->stash(xmlrpc => \@res);
}


#внутренний метод поиска дат отправления
sub searchDatesOfDeparture :XMLRPC {
    my ($self, $c, $params) = @_;

    my @res = $self->next::method(
        cityOfDeparture => $params->{'cityOfDeparture'},
        cityOfArrival   => $params->{'cityOfArrival'},
        startDate       => $params->{'startDate'}
    );

    $c->stash(xmlrpc => \@res);
}


#внутренний метод поиска рейсов
sub searchFlights :XMLRPC {
    my ($self, $c, $params) = @_;

    my @res = $self->next::method(
        cityOfDeparture => $params->{'cityOfDeparture'},
        cityOfArrival   => $params->{'cityOfArrival'},
        dateOfDeparture => $params->{'dateOfDeparture'}
    );

    $c->stash(xmlrpc => \@res);
}


#внутренний метод поиска расписания
sub searchTimetable :XMLRPC {
    my ($self, $c, $params) = @_;

    my @res = $self->next::method(
        cityOfDeparture => $params->{'cityOfDeparture'},
        cityOfArrival   => $params->{'cityOfArrival'},
        dateOfDeparture => $params->{'dateOfDeparture'}
    );

    $c->stash(xmlrpc => \@res);
}

1;
