use Test::More tests => 12;

use strict;
use warnings;

use_ok('ClubSpain::Model::TimeTable');

use lib qw(t/lib);
use ClubSpain::Test;

my $schema = ClubSpain::Test->init_schema();
my $count = $schema->resultset('TimeTable')->search({})->count;

my $timetable = ClubSpain::Model::TimeTable->new(
    is_published      => 1,
    flight_id         => 1,
    airplane_id       => 1,
    departure_date    => '2011-01-21',
    departure_time    => '20:30',
    arrival_date      => '2011-01-22',
    arrival_time      => '01:20',
    departure_terminal_id => undef,
    arrival_terminal_id   => undef
);

my $object = $timetable->create();

isa_ok($object, 'ClubSpain::Schema::TimeTable');
is($object->is_published, 1, 'got is published flag');
is($object->flight_id, 1, 'got flight id');
is($object->airplane_id, 1, 'got airplane id');
is($object->departure_date, '2011-01-21', 'got departure date');
is($object->departure_time, '20:30', 'got departure time');
is($object->arrival_date, '2011-01-22', 'got arrival date');
is($object->arrival_time, '01:20', 'got arrival time');
is($object->departure_terminal_id, undef, 'got departure terminal id');
is($object->arrival_terminal_id, undef, 'got arrival terminal id');


ClubSpain::Model::TimeTable->delete($object->id);

my $rs = $schema->resultset('TimeTable')->search({});
is($rs->count, $count, 'no objects left');
