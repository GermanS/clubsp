package ClubSpain::Controller::RPC;
use strict;
use warnings;
use utf8;
use base qw(Catalyst::Controller);

sub to_array {
    my ($self, $iterator) = @_;

    my @res;
    while (my $item = $iterator->next) {
        push @res, $item->to_hash();
    }

    return @res;
}


sub to_date_hash {
    my ($self, $iterator) = @_;

    my @res;
    while (my $date = $iterator->next) {
        push @res, {
            id   => $date->get_column('dateOfDeparture'),
            name => $date->get_column('dateOfDeparture')
        };
    }

    return @res;
}

sub object_to_date_hash {
    my ($self, $iterator) = @_;

    my @res;
    while (my $date = $iterator->next) {
        push @res, {
            id   => $date->departure_date,
            name => $date->departure_date,
        };
    }

    return @res;
}

sub itinerary_2_hash {
    my ($self, $iterator) = @_;

    my @res;
    while (my $ticket = $iterator->next) {
        push @res, {
            id     => $ticket->{'id'},
            price  => $ticket->{'cost'},
            segments => $self->segments($ticket),
        }
    }

    return @res;
}

sub segments {
    my ($self, $segment) = @_;

    my @res;
    while ($segment) {
        push @res, {
            serviceClass => {
                id   => $segment->{'fare_class'}->{'id'},
                code => $segment->{'fare_class'}->{'code'},
                name => $segment->{'fare_class'}->{'name'},
            },
            $self->timetable_to_hash($segment->{'timetable'})
        };

        $segment = $segment->{'children'}[0];
    }

    return \@res;
}

sub timetable_to_hash {
    my ($self, $timetable) = @_;

    my $flightNumber = sprintf "%2s %4s", $timetable->{'flight'}->{'airline'}->{'iata'},
                                          $timetable->{'flight'}->{'code'};
    return (
        id            => $timetable->{'id'},
        isFree        => $timetable->{'is_free'},
        dateBegin     => $timetable->{'departure_date'},
        timeBegin     => $timetable->{'departure_time'},
        dateEnd       => $timetable->{'arrival_date'},
        timeEnd       => $timetable->{'arrival_time'},
        flightNumber  => $flightNumber,
        board         => {
            id   => $timetable->{'airplane'}->{'id'},
            code => $timetable->{'airplane'}->{'iata'},
            name => $timetable->{'airplane'}->{'name'},
        },
        airline => {
            id   => $timetable->{'flight'}->{'airline'}->{'id'},
            iata => $timetable->{'flight'}->{'airline'}->{'iata'},
            name => $timetable->{'flight'}->{'airline'}->{'name'},
        },
        locationBegin => {
            city => {
                id   => $timetable->{'flight'}->{'departure_airport'}->{'city'}->{'id'},
                iata => $timetable->{'flight'}->{'departure_airport'}->{'city'}->{'iata'},
                name => $timetable->{'flight'}->{'departure_airport'}->{'city'}->{'name'},
            },
            airport => {
                id   => $timetable->{'flight'}->{'departure_airport'}->{'id'},
                iata => $timetable->{'flight'}->{'departure_airport'}->{'iata'},
                name => $timetable->{'flight'}->{'departure_airport'}->{'name'},
            }
        },
        locationEnd => {
            city => {
                id   => $timetable->{'flight'}->{'destination_airport'}->{'city'}->{'id'},
                iata => $timetable->{'flight'}->{'destination_airport'}->{'city'}->{'iata'},
                name => $timetable->{'flight'}->{'destination_airport'}->{'city'}->{'name'},
            },
            airport => {
                id   => $timetable->{'flight'}->{'destination_airport'}->{'id'},
                iata => $timetable->{'flight'}->{'destination_airport'}->{'iata'},
                name => $timetable->{'flight'}->{'destination_airport'}->{'name'},
            },
        }
    );
}

1;
