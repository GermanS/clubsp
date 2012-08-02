use Test::More tests => 25;

use strict;
use warnings;

use_ok('ClubSpain::Model::TimeTable');

use lib qw(t/lib);
use ClubSpain::Test;
my $helper = ClubSpain::Test->new();

#first insert
{
    my $timetable = ClubSpain::Model::TimeTable->new(
        is_published      => 1,
        is_free           => 1,
        flight_id         => 1,
        airplane_id       => 1,
        departure_date    => '2011-01-21',
        departure_time    => '20:30',
        arrival_date      => '2011-01-22',
        arrival_time      => '01:20',
        departure_terminal_id => undef,
        arrival_terminal_id   => undef
    );

    my $result;

    eval {
        $result = $timetable->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Result::TimeTable');
    is($result->is_published, 1, 'got is published flag');
    is($result->is_free, 1, 'got is free flag');
    is($result->flight_id, 1, 'got flight id');
    is($result->airplane_id, 1, 'got airplane id');
    is($result->departure_date, '2011-01-21', 'got departure date');
    is($result->departure_time, '20:30', 'got departure time');
    is($result->arrival_date, '2011-01-22', 'got arrival date');
    is($result->arrival_time, '01:20', 'got arrival time');
    is($result->departure_terminal_id, undef, 'got departure terminal id');
    is($result->arrival_terminal_id, undef, 'got arrival terminal id');

}

#second addition
{
    my $timetable = ClubSpain::Model::TimeTable->new(
        is_published      => 1,
        is_free           => 1,
        flight_id         => 2,
        airplane_id       => 1,
        departure_date    => '2011-01-22',
        departure_time    => '05:30',
        arrival_date      => '2011-01-22',
        arrival_time      => '15:20',
        departure_terminal_id => undef,
        arrival_terminal_id   => undef
    );

    my $result;

    eval {
        $result = $timetable->create();
        pass('no exception thrown');
    };

    if ($@) {
        fail('caught exception');
        use Data::Dumper;
        diag Dumper($@);
    }

    isa_ok($result, 'ClubSpain::Schema::Result::TimeTable');
    is($result->is_published, 1, 'got is published flag');
    is($result->is_free, 1, 'got is free flag');
    is($result->flight_id, 2, 'got flight id');
    is($result->airplane_id, 1, 'got airplane id');
    is($result->departure_date, '2011-01-22', 'got departure date');
    is($result->departure_time, '05:30', 'got departure time');
    is($result->arrival_date, '2011-01-22', 'got arrival date');
    is($result->arrival_time, '15:20', 'got arrival time');
    is($result->departure_terminal_id, undef, 'got departure terminal id');
    is($result->arrival_terminal_id, undef, 'got arrival terminal id');
}
