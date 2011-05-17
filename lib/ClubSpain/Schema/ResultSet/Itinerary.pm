package ClubSpain::Schema::ResultSet::Itinerary;
use strict;
use warnings;
use parent qw(ClubSpain::Schema::ResultSet);

sub searchItinerary {
    my ($self, @params) = @_;

    my $iterator;
    if (scalar @params == 1) {
        $iterator = $self->searchOneWay($params[0])
    } else {
        $iterator = $self->searchRoundTrip(@params);
    }

    return $iterator;
}

sub searchOneWay {
    my ($self, $timetable_id) = @_;

#select *
#    from itinerary as i1
#    left join itinerary as i2 on i2.parent_id = i1.id
#    where i2.id IS  NULL and i1.parent_id=0;

    return $self->result_source->resultset->search({
        'me.timetable_id' => $timetable_id,
        'me.parent_id'    => 0,
        'children.id'     => \'iS NULL'
    }, {
        join => 'children'
    });
}


sub searchRoundTrip {
    my ($self, @timetable_id) = @_;

#   select *
#    from itinerary as i1
#    left join itinerary as i2 on i2.parent_id = i1.id
#    where
#    i1.timetable_id = 7 and
#    i2.timetable_id = 11

    return $self->result_source->resultset->search({
        'me.timetable_id'       => $timetable_id[0],
        'children.timetable_id' => $timetable_id[1]
    }, {
        prefetch => 'children'
    });
}

1;
