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


sub _searchCitiesOfDepartureOW {
    my ($self, $c) = @_;

    my $iterator = $c->model('City')->searchCitiesOfDepartureOW();

    return city_hash($iterator);
}

sub _searchCitiesOfArrivalOW {
    my ($self, $c, %params) = @_;

    my $iterator = $c->model('City')->searchCitiesOfArrivalOW(
        cityOfDeparture => $params{'cityOfDeparture'}
    );

    return city_hash($iterator);
}

sub _searchDatesOfDepartureOW {
    my ($self, $c, %params) = @_;

    my $iterator = $c->model('Itinerary')->searchDatesOfDepartureOW(
        cityOfDeparture => $params{'cityOfDeparture'},
        cityOfArrival   => $params{'cityOfArrival'},
    );

    return date_hash($iterator);
}

sub _searchCitiesOfDeparture1RT {
    my ($self, $c) = @_;

    my $iterator = $c->model('City')->searchCitiesOfDeparture1RT();
    return city_hash($iterator);
}

sub _searchCitiesOfArrival1RT {
    my ($self, $c, %params) = @_;

    my $iterator = $c->model('City')->searchCitiesOfArrival1RT(
        cityOfDeparture1 => $params{'cityOfDeparture1'}
    );

    return city_hash($iterator);
}

sub _searchCitiesOfDeparture2RT {
    my ($self, $c, %params) = @_;

    my $iterator = $c->model('City')->searchCitiesOfDeparture2RT(
        cityOfDeparture1 => $params{'cityOfDeparture1'},
        cityOfArrival1   => $params{'cityOfArrival1'},
    );

    return city_hash($iterator);
}

sub _searchCitiesOfArrival2RT {
    my ($self, $c, %params) = @_;

    my $iterator = $c->model('City')->searchCitiesOfArrival2RT(
        cityOfDeparture1 => $params{'cityOfDeparture1'},
        cityOfArrival1   => $params{'cityOfArrival1'},
        cityOfDeparture2 => $params{'cityOfDeparture2'}
    );

    return city_hash($iterator);
}

sub _searchDatesOfDeparture1RT {
    my ($self, $c, %params) = @_;

    my $iterator = $c->model('Itinerary')->searchDatesOfDeparture1RT(
        cityOfDeparture1 => $params{'cityOfDeparture1'},
        cityOfArrival1   => $params{'cityOfArrival1'},
        cityOfDeparture2 => $params{'cityOfDeparture2'},
        cityOfArrival2   => $params{'cityOfArrival2'},
    );

    return date_hash($iterator);
}

sub _searchDatesOfDeparture2RT {
    my ($self, $c, %params) = @_;

    my $iterator = $c->model('Itinerary')->searchDatesOfDeparture2RT(
        cityOfDeparture1 => $params{'cityOfDeparture1'},
        cityOfArrival1   => $params{'cityOfArrival1'},
        cityOfDeparture2 => $params{'cityOfDeparture2'},
        cityOfArrival2   => $params{'cityOfArrival2'},
        dateOfDeparture1 => $params{'dateOfDeparture1'},
    );

    return date_hash($iterator);
}

sub city_hash {
    my $iterator = shift;

    my @res;
    while (my $city = $iterator->next) {
        push @res, { id => $city->id, name => $city->name };
    }

    return @res;
}

sub date_hash {
    my $iterator = shift;

    my @res;
    while (my $date = $iterator->next) {
        push @res, {
            id   => $date->get_column('dateOfDeparture'),
            name => $date->get_column('dateOfDeparture')
        };
    }

    return @res;
}

1;
