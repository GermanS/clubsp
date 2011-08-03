package ClubSpain::Schema::ResultSet::ViewTimeTable;
use strict;
use warnings;
use utf8;
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

    my %dateOfDeparture = ();
    $dateOfDeparture{'dateOfDeparture'} = \sprintf ">'%s'", $params{'startDate'}
        if $params{'startDate'};

    return
        $self->result_source->resultset->search({
            cityOfDepartureId => $params{'cityOfDeparture'},
            cityOfArrivalId   => $params{'cityOfArrival'},
            %dateOfDeparture
        }, {
            result_class => 'ClubSpain::Schema::Result::TimeTable',
            select      => [ 'timeatableId', 'dateOfDeparture'],
            as          => [ qw(me.id me.departure_date) ],
            group_by    => [ qw(dateOfDeparture) ]
        });
}

sub searchTimetable {
    my ($self, %params) = @_;

    return
        $self->result_source->resultset->search({
            cityOfDepartureId => $params{'cityOfDeparture'},
            cityOfArrivalId   => $params{'cityOfArrival'},
            dateOfDeparture   => $params{'dateOfDeparture'},
        }, {
            select => [ 'timeatableId', 'dateOfDeparture', 'abbr'],
        });
}

1;
