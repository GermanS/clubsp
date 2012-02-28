package ClubSpain::Controller::RPC::Flight;

use strict;
use warnings;
use utf8;

use base qw(Catalyst::Controller);

sub _getCountryOfDeparture : Private {
    my ($self, $c) = @_;

    my $iterator = $c->model('Country')
                     ->searchCountriesOfDeparture();

    my @res;
    while (my $item = $iterator->next) {
        push @res, { id => $item->id, name => $item->name };
    }

    return @res;
}

sub _getCityOfDeparture : Private {
    my ($self, $c, $country) = @_;

    my $iterator = $c->model('City')
                     ->searchCitiesOfDeparture(country => $country);

    my @res;
    while (my $item = $iterator->next) {
        push @res, { id => $item->id, name => $item->name };
    }

    return @res;
}

sub _getAirportOfDeparture : Private {
    my ($self, $c, $city) = @_;

    my $iterator = $c->model('Airport')
                     ->searchAirportsOfDeparture(city => $city);

    my @res;
    while (my $item = $iterator->next) {
        push @res, { id => $item->id, name => $item->name };
    }

    return @res;
}

sub _getCountryOfArrival : Private {
    my ($self, $c) = @_;

    my @res = $self->_getCountryOfDeparture($c);
    push @res, shift @res;

    return @res;
}

sub _getCityOfArrival : Private {
    my ($self, $c, $country) = @_;

    return $self->_getCityOfDeparture($c, $country);
}

sub _getAirportOfArrival : Private {
    my ($self, $c, $city) = @_;

    return $self->_getAirportOfDeparture($c, $city);
}


=head2 _suggest()

    Поиск подсказка городов отправление по начальным буквам.
    Подсказка может быть выполнена по трем первым буквам на кириллице, латинице
    или IATA коду города.

=cut

sub _suggest : Private {
    my ($self, $c, $string) = @_;

    my $iterator = $c->model('City')->suggest($string);

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

1;
