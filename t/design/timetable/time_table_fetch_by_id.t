use Test::More tests => 25;

use strict;
use warnings;

use_ok('ClubSpain::Model::TimeTable');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

#pass id to the function
{
    my $timetable = ClubSpain::Model::TimeTable->fetch_by_id(1);
    isa_ok($timetable, 'ClubSpain::Schema::Result::TimeTable');
    is($timetable->is_published, 1, 'got is published flag');
    is($timetable->flight_id, 1, 'got flight id');
    is($timetable->airplane_id, 3, 'got airplane id');
    is($timetable->departure_date, '2011-02-12', 'got departure date');
    is($timetable->departure_time, '10:00:00', 'got departure time');
    is($timetable->arrival_date, '2011-02-12', 'got arrival date');
    is($timetable->arrival_time, '16:00:00', 'got arrival time');
    is($timetable->departure_terminal_id, undef, 'got departure terminal id');
    is($timetable->arrival_terminal_id, undef, 'got arrival terminal id');
}


#retrive
{
    my $timetable = ClubSpain::Model::TimeTable->new(
        id           => 1,
        is_published      => 1,
        flight_id         => 1,
        airplane_id       => 1,
        departure_date    => '2011-01-01',
        departure_time    => '00:00',
        arrival_date      => '2011-01-01',
        arrival_time      => '00:00',
        departure_terminal_id => undef,
        arrival_terminal_id   => undef
    );

    my $object = $timetable->fetch_by_id();
    isa_ok($object, 'ClubSpain::Schema::Result::TimeTable');
    is($object->is_published, 1, 'got is published flag');
    is($object->flight_id, 1, 'got flight id');
    is($object->airplane_id, 3, 'got airplane id');
    is($object->departure_date, '2011-02-12', 'got departure date');
    is($object->departure_time, '10:00:00', 'got departure time');
    is($object->arrival_date, '2011-02-12', 'got arrival date');
    is($object->arrival_time, '16:00:00', 'got arrival time');
    is($object->departure_terminal_id, undef, 'got departure terminal id');
    is($object->arrival_terminal_id, undef, 'got arrival terminal id');
}

#exception
{
    eval {
        ClubSpain::Model::TimeTable->fetch_by_id(1000);
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find TimeTable: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}

#exception
{
    my $timetable = ClubSpain::Model::TimeTable->new(
        id          => 1000,
        is_published      => 1,
        flight_id         => 1,
        airplane_id       => 1,
        departure_date    => '2011-01-01',
        departure_time    => '00:00',
        arrival_date      => '2011-01-01',
        arrival_time      => '00:00',
        departure_terminal_id => undef,
        arrival_terminal_id   => undef
    );

    eval {
        $timetable->fetch_by_id();
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught ClubSpain::Exception::Storage');
            is($e->message, 'Couldn\'t find TimeTable: 1000!', 'got message');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}
