package ClubSpain::Controller::RPC::Charter;
use strict;
use warnings;
use utf8;
use base qw(ClubSpain::Controller::RPC);

sub searchCitiesOfDeparture {
    my $self = shift;

    my $iterator = $self->_app->model('TimeTable')->searchCitiesOfDeparture();

    return $self->to_array($iterator);
}

sub searchCitiesOfArrival {
    my ($self, %params) = @_;

    my $iterator = $self->_app->model('TimeTable')->searchCitiesOfArrival(
        cityOfDeparture => $params{'cityOfDeparture'}
    );

    return $self->to_array($iterator);
}

sub searchDatesOfDeparture {
    my ($self, %params) = @_;

    my $iterator = $self->_app->model('TimeTable')->searchDatesOfDeparture(
        cityOfDeparture => $params{'cityOfDeparture'},
        cityOfArrival   => $params{'cityOfArrival'},
        startDate       => $params{'startDate'},
    );

    return $self->object_to_date_hash($iterator);
}

sub searchFlights {
    my ($self, %params) = @_;

    my $iterator = $self->_app->model('Flight')->searchFlightsInTimetable(
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

=head2 searchTimetable(%params)

    Выбор расписания по критерию

Входные параметры

    cityOfDeparture - идентификатор города отправления
    cityOfArrival   - идентификатор города прибытия
    dateOfDeparture - дата отправления

    возвращается хеш с идентификаторами расписания и названиями рейсов

=cut

sub searchTimetable {
    my ($self, %params) = @_;

    my $iterator = $self->_app->model('TimeTable')->searchTimetable(
        cityOfDeparture => $params{'cityOfDeparture'},
        cityOfArrival   => $params{'cityOfArrival'},
        dateOfDeparture => $params{'dateOfDeparture'},
    );

    return $self->to_array($iterator);
}


=head2 searchCitiesOfDepartureOW()

    Поиск городов отправления в тарифах в одну сторону

=cut

sub searchCitiesOfDepartureOW {
    my $self = shift;

    my $iterator = $self->_app->model('City')->searchCitiesOfDepartureOW();

    return $self->to_array($iterator);
}

=head2 searchCitiesOfArrivalOW(cityOfDeparture => );

    Поиск городов прибытия из города отправления cityOfDeparture
    в тарифах в одну сторону

=cut

sub searchCitiesOfArrivalOW {
    my ($self, %params) = @_;

    my $iterator = $self->_app->model('City')->searchCitiesOfArrivalOW(
        cityOfDeparture => $params{'cityOfDeparture'}
    );

    return $self->to_array($iterator);
}

=head2 searchDatesOfDepartureOW(cityOfDeparture => , cityOfArrival => )

    Поиск дат тарифов в одну сторону при вылете из города
    cityOfDeparture в город cityOfArrival

=cut

sub searchDatesOfDepartureOW {
    my ($self, %params) = @_;

    my $iterator = $self->_app->model('Itinerary')->searchDatesOfDepartureOW(
        cityOfDeparture => $params{'cityOfDeparture'},
        cityOfArrival   => $params{'cityOfArrival'},
    );

    return $self->to_date_hash($iterator);
}

=head2 searchCitiesOfDeparture1RT()

    Поиск городов отправления в первом сегменте тарифа RT

=cut

sub searchCitiesOfDeparture1RT {
    my $self = shift;

    my $iterator = $self->_app->model('City')->searchCitiesOfDeparture1RT();
    return $self->to_array($iterator);
}

=head2 searchCitiesOfArrival1RT(cityOfDeparture1 => )

    Поиск городов прибытия при отправлении из города cityOfDeparture1
    на первом сегменте тарифов RT

На входе:

    cityOfDeparture1 - идентификатор города отправления 1го сегмента

=cut

sub searchCitiesOfArrival1RT {
    my ($self, %params) = @_;

    my $iterator = $self->_app->model('City')->searchCitiesOfArrival1RT(
        cityOfDeparture1 => $params{'cityOfDeparture1'}
    );

    return $self->to_array($iterator);
}

=head2 searchCitiesOfDeparture2RT(cityOfDeparture1 => , cityOfArrival1 => )

    Поиск городов отправления в тарифах RT на втором сегменте

На входе:

    cityOfDeparture1 - идентификатор города отправления 1го сегмента
    cityOfArrival1   - идентификатор города прибытия 1го сегмента

=cut

sub searchCitiesOfDeparture2RT {
    my ($self, %params) = @_;

    my $iterator = $self->_app->model('City')->searchCitiesOfDeparture2RT(
        cityOfDeparture1 => $params{'cityOfDeparture1'},
        cityOfArrival1   => $params{'cityOfArrival1'},
    );

    return $self->to_array($iterator);
}

=head2 searchCitiesOfArrival2RT(cityOfDeparture1 => , cityOfArrival1 =>, cityOfDeparture2 => )

    Поиск городов прибытия на втором сегменте в тарифах RT

На входе:

    cityOfDeparture1 - идентификатор города отправления 1го сегмента
    cityOfArrival1   - идентификатор города прибытия 1го сегмента
    cityOfDeparture2 - идентификатор города отправления 2го сегмента

=cut

sub searchCitiesOfArrival2RT {
    my ($self, %params) = @_;

    my $iterator = $self->_app->model('City')->searchCitiesOfArrival2RT(
        cityOfDeparture1 => $params{'cityOfDeparture1'},
        cityOfArrival1   => $params{'cityOfArrival1'},
        cityOfDeparture2 => $params{'cityOfDeparture2'}
    );

    return $self->to_array($iterator);
}

=head2 searchDatesOfDeparture1RT(cityOfDeparture1 => , cityOfArrival1, cityOfDeparture2 => , cityOfArrival2 => )

    Поиск дат выполнения рейса на первом сегменте

На входе:

    cityOfDeparture1 - идентификатор города отправления 1го сегмента
    cityOfArrival1   - идентификатор города прибытия 1го сегмента
    cityOfDeparture2 - идентификатор города отправления 2го сегмента
    cityOfArrival2   - идентификатор города прибытия 2го сегмента

=cut

sub searchDatesOfDeparture1RT {
    my ($self, %params) = @_;

    my $iterator = $self->_app->model('Itinerary')->searchDatesOfDeparture1RT(
        cityOfDeparture1 => $params{'cityOfDeparture1'},
        cityOfArrival1   => $params{'cityOfArrival1'},
        cityOfDeparture2 => $params{'cityOfDeparture2'},
        cityOfArrival2   => $params{'cityOfArrival2'},
    );

    return $self->to_date_hash($iterator);
}

=head2 searchDatesOfDeparture2RT(cityOfDeparture1 => , cityOfArrival1 => , cityOfDeparture2 =>, cityOfArrival2 =>, dateOfDeparture1 =>)

    Поиск дат выполнения рейса на втором сегменте

На входе:

    cityOfDeparture1 - идентификатор города отправления 1го сегмента
    cityOfArrival1   - идентификатор города прибытия 1го сегмента
    cityOfDeparture2 - идентификатор города отправления 2го сегмента
    cityOfArrival2   - идентификатор города прибытия 2го сегмента
    dateOfDeparture1 - дата первого сегмента

=cut

sub searchDatesOfDeparture2RT {
    my ($self, %params) = @_;

    my $iterator = $self->_app->model('Itinerary')->searchDatesOfDeparture2RT(
        cityOfDeparture1 => $params{'cityOfDeparture1'},
        cityOfArrival1   => $params{'cityOfArrival1'},
        cityOfDeparture2 => $params{'cityOfDeparture2'},
        cityOfArrival2   => $params{'cityOfArrival2'},
        dateOfDeparture1 => $params{'dateOfDeparture1'},
    );

    return $self->to_date_hash($iterator);
}

=head2 searchRT({cityOfDeparture => , cityOfArrival =>, dateOfDeparture => }, {...})

    Поиск тарифов в обе стороны по заданным критериям.

На входе: двухэлелементный массив хешей

    cityOfDeparture - город отправления
    cityOfArrival   - город прибытия
    dateOfDeparture - дата рейса

=cut

sub searchRT {
    my ($self, @params) = @_;

    my $iterator = $self->_app->model('Itinerary')->itineraries({
        cityOfDeparture => $params[0]{'cityOfDeparture'},
        cityOfArrival   => $params[0]{'cityOfArrival'},
        dateOfDeparture => $params[0]{'dateOfDeparture'}
    }, {
        cityOfDeparture => $params[1]{'cityOfDeparture'},
        cityOfArrival   => $params[1]{'cityOfArrival'},
        dateOfDeparture => $params[1]{'dateOfDeparture'}
    });

    return $self->itinerary_2_hash($iterator);
}

=head searchOW(cityOfDeparture => , cityOfArrival => , dateOfDeparture => )

    Поиск тарифа в одну сторону в тарифах OW

На входе

    cityOfDeparture - идентификатор города отправления
    cityOdArrival   - идентификатор города прибытия
    dateOfDeparture - дата отправления

=cut

sub searchOW {
    my ($self, %params) = @_;

    my $iterator = $self->_app->model('Itinerary')->itineraries({
        cityOfDeparture => $params{'cityOfDeparture'},
        cityOfArrival   => $params{'cityOfArrival'},
        dateOfDeparture => $params{'dateOfDeparture'}
    });

    return $self->itinerary_2_hash($iterator);
}

=head2 viewRT({cityOfDeparture => , cityOdArrival => }, {...})

    Поиск всех тарифов RT по заданным городам

На входе 2х элементный массив хешей

    cityOfDeparture - идентификатор города отправления
    cityOfArrival   - идентификатор города прибытия

=cut

sub viewRT {
    my ($self, @params) = @_;

    my $iterator = $self->_app->model('Itinerary')->itineraries({
        cityOfDeparture => $params[0]{'cityOfDeparture'},
        cityOfArrival   => $params[0]{'cityOfArrival'}
    }, {
        cityOfDeparture => $params[1]{'cityOfDeparture'},
        cityOfArrival   => $params[1]{'cityOfArrival'}
    });

    return $self->itinerary_2_hash($iterator);
}

=head2 viewOW(cityOfDepatrure => , cityOfArrival =>)

    Поиск всех тарифов в одну сторону из города cityOfDepatrure в город cityOfArrival

На входе

    cityOfDeparture - идентификатор города отправления
    cityOfArrival   - идентификатор города прибытия

=cut

sub viewOW {
    my ($self, %params) = @_;

    my $iterator = $self->_app->model('Itinerary')->itineraries({
        cityOfDeparture => $params{'cityOfDeparture'},
        cityOfArrival   => $params{'cityOfArrival'}
    });

    return $self->itinerary_2_hash($iterator);
}



1;
