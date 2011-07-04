package ClubSpain::Schema::ResultSet::ViewItineraryRT;
use strict;
use warnings;
use parent qw(ClubSpain::Schema::ResultSet);

sub searchCitiesOfDeparture1 {
    my $self = shift;

    return
        $self->result_source->resultset->search({}, {
            result_class => 'ClubSpain::Schema::Result::City',
            select      => [ 'cityOfDeparture1Id', 'cityOfDeparture1Name', 'cityOfDeparture1IATA'],
            as          => [ qw(me.id me.name me.iata) ],
            group_by    => [ qw(cityOfDeparture1Id) ]
        });
}

sub searchCitiesOfArrival1 {
    my ($self, %params) = @_;

    return
        $self->result_source->resultset->search({
            cityOfDeparture1Id => $params{'cityOfDeparture1'}
        }, {
            result_class => 'ClubSpain::Schema::Result::City',
            select      => [ 'cityOfArrival1Id', 'cityOfArrival1Name', 'cityOfArrival1IATA'],
            as          => [ qw(me.id me.name me.iata) ],
            group_by    => [ qw(cityOfArrival1Id) ]
        });
}

sub searchCitiesOfDeparture2 {
    my ($self, %params) = @_;

    return
        $self->result_source->resultset->search({
            cityOfDeparture1Id => $params{'cityOfDeparture1'},
            cityOfArrival1Id   => $params{'cityOfArrival1'},
        }, {
            result_class => 'ClubSpain::Schema::Result::City',
            select      => [ 'cityOfDeparture2Id', 'cityOfDeparture2Name', 'cityOfDeparture2IATA'],
            as          => [ qw(me.id me.name me.iata) ],
            group_by    => [ qw(cityOfDeparture2Id) ]
        });
}

sub searchCitiesOfArrival2 {
    my ($self, %params) = @_;

    return
        $self->result_source->resultset->search({
            cityOfDeparture1Id => $params{'cityOfDeparture1'},
            cityOfArrival1Id   => $params{'cityOfArrival1'},
            cityOfDeparture2Id => $params{'cityOfDeparture2'},
        }, {
            result_class => 'ClubSpain::Schema::Result::City',
            select      => [ 'cityOfArrival2Id', 'cityOfArrival2Name', 'cityOfArrival2IATA'],
            as          => [ qw(me.id me.name me.iata) ],
            group_by    => [ qw(cityOfArrival2Id) ]
        });
}

sub searchDatesOfDeparture1RT {
    my ($self, %params) = @_;

    return
        $self->result_source->resultset->search({
            cityOfDeparture1Id => $params{'cityOfDeparture1'},
            cityOfArrival1Id   => $params{'cityOfArrival1'},
            cityOfDeparture2Id => $params{'cityOfDeparture2'},
            cityOfArrival2Id   => $params{'cityOfArrival2'},
        }, {
            select      => [ 'dateOfDeparture1'],
            as          => [ qw(me.dateOfDeparture) ],
            group_by    => [ qw(me.dateOfDeparture1) ]
        });
}

sub searchDatesOfDeparture2RT {
    my ($self, %params) = @_;

    return
        $self->result_source->resultset->search({
            cityOfDeparture1Id => $params{'cityOfDeparture1'},
            cityOfArrival1Id   => $params{'cityOfArrival1'},
            cityOfDeparture2Id => $params{'cityOfDeparture2'},
            cityOfArrival2Id   => $params{'cityOfArrival2'},
            dateOfDeparture1   => $params{'dateOfDeparture1'},
        }, {
            select      => [ 'dateOfDeparture2'],
            as          => [ qw(me.dateOfDeparture) ],
            group_by    => [ qw(me.dateOfDeparture2) ]
        });
}


1;
