use Test::More tests => 13;
use strict;
use warnings;

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

use_ok('ClubSpain::Model::TimeTable');

my $timetable = ClubSpain::Model::TimeTable->new(
    id                => 1,
    is_published      => 0,
    is_free           => 1,
    flight_id         => 2,
    airplane_id       => 2,
    departure_date    => '2012-01-01',
    departure_time    => '01:01',
    arrival_date      => '2012-01-01',
    arrival_time      => '02:02',
    departure_terminal_id => undef,
    arrival_terminal_id   => undef
);

my $result = $timetable->update();

isa_ok($result, 'ClubSpain::Schema::Result::TimeTable');
is $result->id, 1
    => 'got id';
is $result->is_published, 0
    => 'got is published flag';
is $result->is_free, 1
    => 'got is free flag';
is $result->flight_id, 2
    => 'got flight id';
is $result->airplane_id, 2
    => 'got airplane id';
is $result->departure_date, '2012-01-01'
    => 'got departure date';
is $result->departure_time, '01:01'
    => 'got departure time';
is $result->arrival_date, '2012-01-01'
    => 'got arrival date';
is $result->arrival_time, '02:02'
    => 'got arrival time';
is $result->departure_terminal_id, undef
    => 'got terminal id';
is $result->arrival_terminal_id, undef
    => 'got arrival terminal id';
