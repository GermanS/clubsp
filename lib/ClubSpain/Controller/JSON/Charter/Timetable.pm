package ClubSpain::Controller::JSON::Charter::Timetable;
use strict;
use warnings;
use utf8;
use base qw(ClubSpain::Controller::RPC::Flight::TimeTable);

#поиск в расписании городов отправления
sub getCitiesOfDeparture :Local {
    my ($self, $c) = @_;

    my @res = $self->_getCitiesOfDeparture($c);

    $c->stash(json_data => \@res);
    $c->forward('View::JSON');
}



#поиск в расписании городов прибытия
sub getCitiesOfArrival :Local {
    my ($self, $c) = @_;

    my @res = $self->_getCitiesOfArrival($c,
        $c->request->param('cityOfDeparture')
    );

    $c->stash(json_data => \@res);
    $c->forward('View::JSON');
}



#поиск в расписании рейсов
sub searchFlights :Local {
    my ($self, $c) = @_;

    my @res = $self->_searchFlights($c, {
        cityOfDeparture => $c->request->param('cityOfDeparture'),
        cityOfArrival   => $c->request->param('cityOfArrival')
    });

    $c->stash(json_data => \@res);
    $c->forward('View::JSON');
}

1;
