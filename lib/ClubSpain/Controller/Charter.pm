package ClubSpain::Controller::Charter;

use strict;
use warnings;
use utf8;

use DateTime;
use DateTime::Format::MySQL;

use parent qw(Catalyst::Controller);

sub auto :Private {
    my ($self, $c) = @_;

    $c->stash(
        template  => 'common/charter/itinerary_search_RT_simple.tt2'
    );
}

sub default :Path {
    my ($self, $c, $direction, $brief) = @_;

    my ($codeOfDeparture, $codeOfArrival) = split('-', $direction);
    if ($codeOfDeparture && $codeOfArrival) {
        my $cityOfDeparture = $c->model('City')->search({ iata => $codeOfDeparture, is_published => 1 })->single;
        my $cityOfArrival   = $c->model('City')->search({ iata => $codeOfArrival,   is_published => 1 })->single;

        if ($cityOfArrival && $cityOfDeparture) {
            my $iterator = $self->itineraries($c, {
                cityOfDeparture => $cityOfDeparture->id,
                cityOfArrival   => $cityOfArrival->id
            }, {
                cityOfDeparture => $cityOfArrival->id,
                cityOfArrival   => $cityOfDeparture->id
            });

            $c->stash(
                cityOfDeparture1 => $cityOfDeparture,
                cityOfArrival1   => $cityOfArrival,
                cityOfDeparture2 => $cityOfArrival,
                cityOfArrival2   => $cityOfDeparture,

                CityOfDeparture1 => $cityOfDeparture->id,
                CityOfArrival1   => $cityOfArrival->id,
                CityOfDeparture2 => $cityOfArrival->id,
                CityOfArrival2   => $cityOfDeparture->id,

                title => sprintf("Авиабилеты %s %s", $cityOfDeparture->name_ru, $cityOfArrival->name_ru),
            );
        }

        $self->brief($c)
            if $brief;
    }
}



sub base :Chained('/charter') :PathPart('') :CaptureArgs(0) { }



sub searchRT :Local {
    my ($self, $c) = @_;

    $self->setup_stash_from_request($c);

    my $cityOfDeparture1 = $c->stash->{'CityOfDeparture1'};
    my $cityOfArrival1   = $c->stash->{'CityOfArrival1'};
    my $dateOfDeparture1 = $c->stash->{'DateOfDeparture1'};

    my $cityOfDeparture2 = $c->stash->{'CityOfDeparture2'};
    my $cityOfArrival2   = $c->stash->{'CityOfArrival2'};
    my $dateOfDeparture2 = $c->stash->{'DateOfDeparture2'};

    if ($cityOfArrival1 && $cityOfDeparture1 && $dateOfDeparture1 &&
        $cityOfArrival2 && $cityOfDeparture2 && $dateOfDeparture2) {

        my $iterator = $self->itineraries($c, {
                cityOfDeparture => $cityOfDeparture1,
                cityOfArrival   => $cityOfArrival1,
                dateOfDeparture => $dateOfDeparture1
            }, {
                cityOfDeparture => $cityOfDeparture2,
                cityOfArrival   => $cityOfArrival2,
                dateOfDeparture => $dateOfDeparture2
        });
    }

    $c->stash(
        template => 'common/charter/itinerary_search_RT.tt2'
    );
}

sub searchOW :Local {
    my ($self, $c) = @_;

    $self->setup_stash_from_request($c);

    my $cityOfDeparture = $c->stash->{'CityOfDeparture1'};
    my $cityOfArrival   = $c->stash->{'CityOfArrival1'};
    my $dateOfDeparture = $c->stash->{'DateOfDeparture1'};

    if ($cityOfDeparture && $cityOfArrival && $dateOfDeparture) {
        $self->itineraries($c, {
            cityOfDeparture => $cityOfDeparture,
            cityOfArrival   => $cityOfArrival,
            dateOfDeparture => $dateOfDeparture
        });
    }

    $c->stash(
        template => 'common/charter/itinerary_search_OW.tt2'
    );
}

sub viewRT :Local {
    my ($self, $c) = @_;

    $self->setup_stash_from_request($c);

    my $cityOfDeparture1 = $c->stash->{'CityOfDeparture1'};
    my $cityOfArrival1   = $c->stash->{'CityOfArrival1'};
    my $cityOfDeparture2 = $c->stash->{'CityOfDeparture2'};
    my $cityOfArrival2   = $c->stash->{'CityOfArrival2'};

    if ($cityOfDeparture1 && $cityOfArrival1 &&
        $cityOfDeparture2 && $cityOfArrival2) {

        $self->itineraries($c, {
            cityOfDeparture => $cityOfDeparture1,
            cityOfArrival   => $cityOfArrival1
        }, {
            cityOfDeparture => $cityOfDeparture2,
            cityOfArrival   => $cityOfArrival2
        });
    }

    $c->stash(
        template => 'common/charter/itinerary_search_RT_simple.tt2'
    );
}

sub viewOW :Local {
    my ($self, $c) = @_;

    $self->setup_stash_from_request($c);

    my $cityOfDeparture1 =
        $c->stash->{'CityOfDeparture1'};
    my $cityOfArrival1 =
        $c->stash->{'CityOfArrival1'};

    if ($cityOfDeparture1 && $cityOfArrival1) {
        $self->itineraries($c, {
            cityOfDeparture => $cityOfDeparture1,
            cityOfArrival   => $cityOfArrival1
        });
    }

    $c->stash(
        template => 'common/charter/itinerary_search_OW_simple.tt2'
    );
}

sub end :ActionClass('RenderView') {}

sub setup_stash_from_request {
    my ($self, $c) = @_;

    my @param = qw(CityOfDeparture1
                   CityOfArrival1
                   CityOfDeparture2
                   CityOfArrival2);

    $c->stash({ $_ => $c->request->param($_) || undef})
        foreach (@param, qw(DateOfDeparture1 DateOfDeparture2));

    $c->stash({
        lcfirst $_ => $c->stash->{$_} ? $c->model('City')->fetch_by_id($c->stash->{$_}) : undef
    }) foreach (@param);
}

sub header {
    my ($c, $key) = @_;

    my $cityOfDeparture1 = $c->stash->{'cityOfDeparture1'};
    my $cityOfArrival1   = $c->stash->{'cityOfArrival1'};
    my $cityOfDeparture2 = $c->stash->{'cityOfDeparture2'};
    my $cityOfArrival2   = $c->stash->{'cityOfArrival2'};
    my $dateOfDeparture1 = $c->stash->{'DateOfDeparture1'};
    my $dateOfDeparture2 = $c->stash->{'DateOfDeparture2'};

    my %headers = (
       OW_ALL => sprintf("Стоимость авиабилетов %s - %s",
                         $cityOfDeparture1->name,
                         $cityOfArrival1->name),
       OW     => sprintf("Стоимость авиабилета %s - %s c %s по %s",
                         $cityOfDeparture1->name,
                         $cityOfArrival1->name,
                         $dateOfDeparture1,
                         $dateOfDeparture2),
       RT_ALL => sprintf("Стоимость авиабилетов %s - %s, %s - %s",
                         $cityOfDeparture1->name,
                         $cityOfArrival1->name,
                         $cityOfDeparture2->name,
                         $cityOfArrival2->name),
       RT     => sprintf("Стоимость авиабилета %s - %s, %s - %s с %s по %s",
                         $cityOfDeparture1->name,
                         $cityOfArrival1->name,
                         $cityOfDeparture2->name,
                         $cityOfArrival2->name,
                         $dateOfDeparture1,
                         $dateOfDeparture2),
    );

    return $headers{$key};
}

sub brief :Local  {
    my ($self, $c) = @_;

    my $iterator = $c->stash->{'iterator'};
    my ($res, $days) = $self->as_table($iterator);

    $c->stash(
        template => 'common/charter/itinerary_search_RT_brief.tt2',
        table    => $res,
        days     => $days,
    );
}

sub itineraries :Private {
    my ($self, $c, @params) = @_;

    my $iterator = $c->model('Itinerary')->itineraries(@params);
    $c->stash(iterator => $iterator);
}

sub as_table {
    my ($self, $iterator) = @_;

    my $table = {};
    my %dur = ();
    while (my $row = $iterator->next) {
        my $return = $row->{'children'}[0];

        my $dateOfDeparture1 =
            DateTime::Format::MySQL->parse_date(
                $row->{'timetable'}{'departure_date'}
            );
        my $dateOfDeparture2 =
            DateTime::Format::MySQL->parse_date(
                $return->{'timetable'}{'departure_date'}
            );

        my $duration =
            $dateOfDeparture2->subtract_datetime($dateOfDeparture1);
        my $days =
            $duration->in_units( 'days' );

        $dur{$days} = $days;

        my $flights = sprintf("%2s%4s (%s) / %2s%4s (%s)",
            $row->{'timetable'}->{'flight'}->{'airline'}->{'iata'},
            $row->{'timetable'}->{'flight'}->{'code'},
            $row->{'fare_class'}->{'code'},
            $return->{'timetable'}->{'flight'}->{'airline'}->{'iata'},
            $return->{'timetable'}->{'flight'}->{'code'},
            $return->{'fare_class'}->{'code'}
        );

        $table->{$row->{'timetable'}->{'departure_date'}}
              ->{$flights}
              ->{$days}
                = [ $row->{'cost'}, $row->{'id'} ];

    }
    my @all_days = sort { $a <=> $b } keys %dur;

    return ($table, \@all_days);
}

1;
