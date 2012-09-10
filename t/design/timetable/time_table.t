use Test::More tests => 9;

use strict;
use warnings;

use_ok('ClubSpain::Model::TimeTable');

my $timetable = ClubSpain::Model::TimeTable->new(
    is_published      => 1,
    flight_id         => 1,
    airplane_id       => 1,
    departure_date    => '2011-01-21',
    departure_time    => '20:30',
    arrival_date      => '2011-01-21',
    arrival_time      => '01:20',
);


isa_ok($timetable, 'ClubSpain::Model::TimeTable');
is $timetable->get_is_published, 1
    => 'got is published';
is $timetable->get_flight_id, 1
    => 'got flight id';
is $timetable->get_departure_date, '2011-01-21'
    => 'got departure date';
is $timetable->get_departure_time, '20:30'
    => 'got departure time';
is $timetable->get_arrival_date, '2011-01-21'
    => 'got arrival date';
is $timetable->get_arrival_time, '01:20'
    => 'got arrival time';
is $timetable->get_airplane_id, 1
    => 'got airplane id';
