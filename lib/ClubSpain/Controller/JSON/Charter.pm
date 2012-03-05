package ClubSpain::Controller::JSON::Charter;
use strict;
use warnings;
use utf8;
use base qw(ClubSpain::Controller::RPC::Charter);

#поиск городов отрпавления для тарифов в одну сторону
sub searchCitiesOfDepartureOW :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method();
    $c->stash(json_data => \@res);
}



#поиск городов прибытия для тарифов в одну сторону
sub searchCitiesOfArrivalOW :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method(
        cityOfDeparture => $c->request->param('cityOfDeparture'),
    );

    $c->stash(json_data => \@res);
}



#поиск дат для тарифов в одну сторону
sub searchDatesOfDepartureOW :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method(
        cityOfDeparture => $c->request->param('cityOfDeparture'),
        cityOfArrival   => $c->request->param('cityOfArrival')
    );

    $c->stash(json_data => \@res);
}



#поиск городов отправления в первом сегменте для тарифов туда и обратно
sub searchCitiesOfDeparture1RT :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method();
    $c->stash(json_data => \@res);
}



#поиск городов прибытия в первом сегменте для тарифов туда и обратно
sub searchCitiesOfArrival1RT :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method(
        cityOfDeparture1 => $c->request->param('cityOfDeparture1')
    );

    $c->stash(json_data => \@res);
}



#поиск городов отправления во втором сегменте для тарифов туда и обратно
sub searchCitiesOfDeparture2RT :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method(
        cityOfDeparture1 => $c->request->param('cityOfDeparture1'),
        cityOfArrival1   => $c->request->param('cityOfArrival1')
    );

    $c->stash(json_data => \@res);
}



#поиск городов прибытия во втором сегменте для тарифов туда и обратно
sub searchCitiesOfArrival2RT :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method(
        cityOfDeparture1 => $c->request->param('cityOfDeparture1'),
        cityOfArrival1   => $c->request->param('cityOfArrival1'),
        cityOfDeparture2 => $c->request->param('cityOfDeparture2')
    );

    $c->stash(json_data => \@res);
}



#поиск дат первого сегмента для тарифов туда и обратно
sub searchDatesOfDeparture1RT :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method(
        cityOfDeparture1 => $c->request->param('cityOfDeparture1'),
        cityOfArrival1   => $c->request->param('cityOfArrival1'),
        cityOfDeparture2 => $c->request->param('cityOfDeparture2'),
        cityOfArrival2   => $c->request->param('cityOfArrival2')
    );

    $c->stash(json_data => \@res);
}



#поиск дат второго сегмента для тарифов туда и обратно
sub searchDatesOfDeparture2RT :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method(
        cityOfDeparture1 => $c->request->param('cityOfDeparture1'),
        cityOfArrival1   => $c->request->param('cityOfArrival1'),
        cityOfDeparture2 => $c->request->param('cityOfDeparture2'),
        cityOfArrival2   => $c->request->param('cityOfArrival2'),
        dateOfDeparture1 => $c->request->param('dateOfDeparture1'),
    );

    $c->stash(json_data => \@res);
}



#внутренний метод поиска городов отправления
sub searchCitiesOfDeparture :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method();
    $c->stash(json_data => \@res);
}



#внутренний метод поиска городов прибытия
sub searchCitiesOfArrival :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method(
        cityOfDeparture => $c->request->param('cityOfDeparture')
    );

    $c->stash(json_data => \@res);
}



#внутренний метод поиска дат отправления
sub searchDatesOfDeparture :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method(
        cityOfDeparture => $c->request->param('cityOfDeparture'),
        cityOfArrival   => $c->request->param('cityOfArrival'),
        startDate       => $c->request->param('startDate')
    );

    $c->stash(json_data => \@res);
}



#внутренний метод поиска рейсов
sub searchFlights :Local {
    my ($self, $c) = @_;

    my @res = $self->next::method(
        cityOfDeparture => $c->request->param('cityOfDeparture'),
        cityOfArrival   => $c->request->param('cityOfArrival'),
        dateOfDeparture => $c->request->param('dateOfDeparture')
    );

    $c->stash(json_data => \@res);
}



#внутренний метод поиска расписания
sub searchTimetable :Local {
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
