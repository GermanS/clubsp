package ClubSpain::Controller::RPC::Charter::TimeTable;
use strict;
use warnings;
use utf8;
use base qw(ClubSpain::Controller::RPC);

sub getCitiesOfDeparture {
    my $self = shift;

    my $iterator = $self->_app->model('City')->searchCitiesOfDepartureInFlight();
    return $self->to_array($iterator);
}

sub getCitiesOfArrival {
    my ($self, $cityOfDeparture) = @_;

    my $iterator = $self->_app
                        ->model('City')
                        ->searchCitiesOfArrivalInFlight(cityOfDeparture => $cityOfDeparture);
    return $self->to_array($iterator);
}

sub searchFlights {
    my ($self, $params) = @_;

    return
        unless $params->{'cityOfDeparture'} && $params->{'cityOfArrival'};

    my $iterator = $self->_app->model('Flight')->searchFlights(
        cityOfDeparture => $params->{'cityOfDeparture'},
        cityOfArrival   => $params->{'cityOfArrival'},
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


=head2 findCitiesOfDeparture()

    Поиск городов отправления в расписании.
    Метод применяется для общения с внешними системами.

=cut

sub findCitiesOfDeparture {
    my $self = shift;

    my $iterator = $self->_app->model('TimeTable')->searchCitiesOfDeparture();
    return $self->to_array($iterator);
}



=head2 findCitiesOfArrival(cityOfDeparture => )

    Поиск городов прибытия в расписании в зависиморсти от города вылета.
    Метод применяется для общения с внешними системами.

На входе:

    cityOfDeparture - идентификатор города отправления

=cut

sub findCitiesOfArrival {
    my ($self, %params) = @_;

    my $iterator = $self->_app->model('TimeTable')->searchCitiesOfArrival(
        cityOfDeparture => $params{'cityOfDeparture'}
    );

    return $self->to_array($iterator);
}

=head2 findDatesOfDeparture(cityOfDeparture => , cityOfArrival => )

    Поиск возможных дат отправление в расписании из города cityOfDeparture
    в город cityOfArrival

На входе:

    cityOfDeparture - идентификатор города отправления
    cityOfArrival   - идентификатор города прибытия

=cut

sub findDatesOfDeparture {
    my ($self, %params) = @_;

    my $iterator = $self->_app->model('TimeTable')->searchDatesOfDeparture(
        cityOfDeparture => $params{'cityOfDeparture'},
        cityOfArrival   => $params{'cityOfArrival'},
        startDate       => $params{'startDate'},
    );

    return $self->object_to_date_hash($iterator);
}

=head2 findFlights(cityOfDeparture => , cityOfArrival => , dateOfDeparture => )

    Поиск авиарейсов в расписании из города cityOfDeparture в городо cityOfArrival
    на дату dateOfDeparture

На входе:

    cityOfDeparture - идентификатор города отправления
    cityOfArrival   - идентификатор города прибытия
    dateOfDeparture - дата выполнения рейса

=cut

sub findFlights {
    my ($self, %params) = @_;

    my $iterator = $self->_app->model('TimeTable')->searchTimetable(
        cityOfDeparture => $params{'cityOfDeparture'},
        cityOfArrival   => $params{'cityOfArrival'},
        dateOfDeparture => $params{'dateOfDeparture'}
    );

    my @res;
    while (my $row = $iterator->next) {
        push @res, $self->_app->model('TimeTable')
                        ->fetch_by_id($row->id)
                        ->to_hash();
    }

    return @res;

}

1;
