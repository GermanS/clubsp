package ClubSpain::Controller::RPC::Flight;

use strict;
use warnings;

use base qw(Catalyst::Controller);

sub _getCountryOfDeparture : Private {
    my ($self, $c) = @_;

    my $iterator = $c->model('Country')->search({
        'me.is_published'      => 1,
        'city.is_published'    => 1,
        'airport.is_published' => 1,
    }, {
        where  => [ -and => {
            'city.country_id ' => \'=me.id',
            'airport.city_id'  => \'=city.id'
        }],
        from     => [ 'country as me, city, airport' ],
        group_by => 'me.id'
    });

    my @res;
    while (my $item = $iterator->next) {
        push @res, { id => $item->id, name => $item->name };
    }

    return @res;
}

sub _getCityOfDeparture : Private {
    my ($self, $c, $country) = @_;

    my $iterator = $c->model('City')->search({
        'me.is_published'      => 1,
        'airport.is_published' => 1,
        'me.country_id'        => $country
    }, {
        where => [ -and => {
            'airport.city_id' => \'=me.id'
        }],
        from     => [ 'city as me, airport' ],
        group_by => 'me.id',
    });

    my @res;
    while (my $item = $iterator->next) {
        push @res, { id => $item->id, name => $item->name };
    }

    return @res;
}

sub _getAirportOfDeparture : Private {
    my ($self, $c, $city) = @_;

    my $iterator = $c->model('Airport')->search({
        is_published => 1,
        city_id      => $city,
    });

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

1;
