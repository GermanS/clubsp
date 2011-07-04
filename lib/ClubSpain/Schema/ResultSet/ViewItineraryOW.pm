package ClubSpain::Schema::ResultSet::ViewItineraryOW;
use strict;
use warnings;
use parent qw(ClubSpain::Schema::ResultSet);

sub searchCitiesOfDeparture {
    my $self = shift;

    return
        $self->result_source->resultset->search({}, {
            result_class => 'ClubSpain::Schema::Result::City',
            select      => [ 'cityOfDepartureId', 'cityOfDepartureName', 'cityOfDepartureIATA'],
            as          => [ qw(me.id me.name me.iata) ],
            group_by    => [ qw(cityOfDepartureId) ]
        });
}

sub searchCitiesOfArrival {
    my ($self, %params) = @_;

    return
        $self->result_source->resultset->search({
            cityOfDepartureId => $params{'cityOfDeparture'}
        }, {
            result_class => 'ClubSpain::Schema::Result::City',
            select      => [ 'cityOfArrivalId', 'cityOfArrivalName', 'cityOfArrivalIATA'],
            as          => [ qw(me.id me.name me.iata) ],
            group_by    => [ qw(cityOfArrivalId) ]
        });
}

sub searchDatesOfDeparture {
    my ($self, %params) = @_;

    return
        $self->result_source->resultset->search({
            cityOfDepartureId => $params{'cityOfDeparture'},
            cityOfArrivalId   => $params{'cityOfArrival'},
        }, {
            select      => [ 'dateOfDeparture'],
            group_by    => [ qw(dateOfDeparture) ]
        });
}

1;
