package ClubSpain::Controller::JSON::Charter::Timetable;
use strict;
use warnings;
use utf8;
use base qw(ClubSpain::Controller::RPC::Charter::TimeTable);

#поиск в расписании городов отправления
sub getCitiesOfDeparture :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method();
    $c->stash(json_data => \@res);
}


#поиск в расписании городов прибытия
sub getCitiesOfArrival :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method(
        $c->request->param('cityOfDeparture')
    );

    $c->stash(json_data => \@res);
}

#поиск  рейсов в расписании
sub searchFlights :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method({
        cityOfDeparture => $c->request->param('cityOfDeparture'),
        cityOfArrival   => $c->request->param('cityOfArrival')
    });

    $c->stash(json_data => \@res);
}

#передача городов отправления с внешним источникам
sub findCitiesOfDeparture :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method();
    $c->stash(json_data => \@res);
}

#передача городов прибытия с внешним источникам
sub findCitiesOfArrival :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method(
        cityOfDeparture => $c->request->param('cityOfDeparture')
    );
    $c->stash(json_data => \@res);
}

#передача дат внешним источникам
sub findDatesOfDeparture :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method(
        cityOfDeparture => $c->request->param('cityOfDeparture'),
        cityOfArrival   => $c->request->param('cityOfArrival')
    );
    $c->stash(json_data => \@res);
}

#передача расписания внешним источникам
sub findFlights :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method(
        cityOfDeparture => $c->request->param('cityOfDeparture'),
        cityOfArrival   => $c->request->param('cityOfArrival'),
        dateOfDeparture => $c->request->param('dateOfDeparture')
    );
    $c->stash(json_data => \@res);
}

sub end :Private {
    my ($self, $c) = @_;

    $c->forward('View::JSON');
}

1;
