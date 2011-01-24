use Test::More tests => 10;

use strict;
use warnings;

use_ok('ClubSpain::Design::TimeTable');

my $timetable = ClubSpain::Design::TimeTable->new(
    flight_id         => 1,
    airplane_id       => 1,
    departure_date    => '2011-01-21',
    departure_time    => '20:30',
    arrival_date      => '2011-01-21',
    arrival_time      => '01:20',
    departure_terminal_id => 1,
    arrival_terminal_id   => 2
);


isa_ok($timetable, 'ClubSpain::Design::TimeTable');
is($timetable->flight_id,               1, 'got flight id');
is($timetable->departure_date,          '2011-01-21', 'got departure date');
is($timetable->departure_time,          '20:30', 'got departure time');
is($timetable->arrival_date,            '2011-01-21', 'got arrival date');
is($timetable->arrival_time,            '01:20', 'got arrival time');
is($timetable->airplane_id,             1, 'got airplane id');
is($timetable->departure_terminal_id,   1, 'got departure terminal id');
is($timetable->arrival_terminal_id,     2, 'got arrival terminal id');
