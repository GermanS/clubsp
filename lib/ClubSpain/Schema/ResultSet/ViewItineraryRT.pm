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
            cityOfDeparture1Id => $params{'cityOfDeparture'}
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
            cityOfDeparture1Id => $params{'cityOfDeparture'},
            cityOfArrival1Id   => $params{'cityOfArrival'},
        }, {
            result_class => 'ClubSpain::Schema::Result::City',
            select      => [ 'cityOfDeparture2Id', 'cityOfDeparture2Name', 'cityOfDeparture2IATA'],
            as          => [ qw(me.id me.name me.iata) ],
            group_by    => [ qw(cityOfDeparture2Id) ]
        });
}


1;
