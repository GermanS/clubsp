package ClubSpain::Controller::RPC::Location;

use strict;
use warnings;
use utf8;

use base qw(Catalyst::Controller);

sub getCountryOfDeparture : Private {
    my $self = shift;

    my $iterator = $self->_app
                        ->model('Country')
                        ->searchCountriesOfDeparture();

    return $self->formatter($iterator);
}

sub getCityOfDeparture : Private {
    my ($self, $country) = @_;

    my $iterator = $self->_app
                        ->model('City')
                        ->searchCitiesOfDeparture(country => $country);

    return $self->formatter($iterator);
}

sub getAirportOfDeparture : Private {
    my ($self, $city) = @_;

    my $iterator = $self->_app
                        ->model('Airport')
                        ->searchAirportsOfDeparture(city => $city);

    return $self->formatter($iterator);
}

sub getCountryOfArrival : Private {
    my $self = shift;

    my @res = getCountryOfDeparture($self);
    push @res, shift @res;

    return @res;
}

sub getCityOfArrival : Private {
    my ($self, $country) = @_;

    return getCityOfDeparture($self, $country);
}

sub getAirportOfArrival : Private {
    my ($self, $city) = @_;

    return getAirportOfDeparture($self, $city);
}


=head2 _suggest()

    Поиск подсказка городов отправление по начальным буквам.
    Подсказка может быть выполнена по трем первым буквам на кириллице, латинице
    или IATA коду города.

=cut

sub suggest : Private {
    my ($self, $string) = @_;

    my $iterator = $self->_app->model('City')->suggest($string);

    my @res = ();
    return @res unless $iterator;

    while (my $city = $iterator->next) {
        push @res, {
            id    => $city->id,
            iata => $city->iata,
            name => $city->name,
            name_ru => $city->name_ru,
            label => sprintf("%s (%s)", $city->name_ru, $city->country->name),
            value => sprintf("%s (%s)", $city->name_ru, $city->iata),
        };
    }

    return @res;
}

#простой форматер для структуры id =>, name =>
sub formatter :Private {
    my ($self, $iterator) = @_;

    my @res;
    while (my $item = $iterator->next) {
        push @res, { id => $item->id, name => $item->name };
    }

    return @res;
}

1;
