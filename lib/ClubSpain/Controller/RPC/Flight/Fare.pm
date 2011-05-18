package ClubSpain::Controller::RPC::Flight::Fare;
use strict;
use warnings;
use base qw(Catalyst::Controller);

sub _searchCitiesOfDeparture {
    my ($self, $c) = @_;

    my $iterator =
        $c->model('City')->searchCitiesOfDepartureInTimeTable();

    my @res;
    while (my $item = $iterator->next) {
        push @res, { id => $item->id, name => $item->name };
    }

    return @res;
}

sub _searchCitiesOfArrival {
    my ($self, $c, %params) = @_;

    my $iterator =
        $c->model('City')
          ->searchCitiesOfArrivalInTimeTable(
              cityOfDeparture => $params{'cityOfDeparture'}
            );

    my @res;
    while (my $item = $iterator->next) {
        push @res, { id => $item->id, name => $item->name };
    }

    return @res;
}

sub _searchDatesOfDeparture {
    my ($self, $c, %params) = @_;

    my $iterator = $c->model('TimeTable')->searchDatesOfDeparture(
        cityOfDeparture => $params{'cityOfDeparture'},
        cityOfArrival   => $params{'cityOfArrival'},
        startDate       => $params{'startDate'},
    );

    my @res;
    while (my $item = $iterator->next) {
        push @res, { id => $item->departure_date, name => $item->departure_date };
    }

    return @res;
}

sub _searchFlights {
    my ($self, $c, %params) = @_;

    my $iterator = $c->model('Flight')->searchFlightsInTimetable(
        cityOfDeparture => $params{'cityOfDeparture'},
        cityOfArrival   => $params{'cityOfArrival'},
        dateOfDeparture => $params{'dateOfDeparture'}
    );

    my @res;
    while (my $item = $iterator->next) {
        my $name = sprintf "%s %s (%s - %s)",
            $item->airline->iata,
            $item->code,
            $item->departure_airport->iata,
            $item->destination_airport->iata;
        push @res, { id => $item->id, name => $name };
    }

    return @res;
}

=head2 _searchTimetable(%params)

Выбор расписания по критерию
входные параметры
cityOfDeparture - идентификатор города отправления
cityOfArrival   - идентификатор города прибытия
dateOfDeparture - дата отправления

возвращается хеш с идентификаторами расписания и названиеми рейсов

=cut

sub _searchTimetable {
    my ($self, $c, %params) = @_;

    my $iterator = $c->model('TimeTable')->searchTimetable(
        cityOfDeparture => $params{'cityOfDeparture'},
        cityOfArrival   => $params{'cityOfArrival'},
        dateOfDeparture => $params{'dateOfDeparture'},
    );

    my @res;
    while (my $item = $iterator->next) {
        my $name = sprintf "%s %s (%s - %s)",
            $item->flight->airline->iata,
            $item->flight->code,
            $item->flight->departure_airport->iata,
            $item->flight->destination_airport->iata;
        push @res, { id => $item->id, name => $name };
    }

    return @res;
}

1;
