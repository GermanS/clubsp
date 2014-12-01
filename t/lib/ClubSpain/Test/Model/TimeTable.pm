package ClubSpain::Test::Model::TimeTable;

use strict;
use warnings;

use ClubSpain::Model::TimeTable;

use TryCatch;

use lib qw(t/lib);
use ClubSpain::Test;

use Test::More;
use base qw(Test::Class);

sub setup :Test(startup) {
    my $self = shift;

    $self -> { 'schema' } = ClubSpain::Test -> new();

    return;
}

sub test_00_simple :Test( 8 ) {
    my $self = shift;

    my %params = (
        is_published   => 1,
        flight_id      => 1,
        airplane_id    => 1,
        departure_date => '2011-01-21',
        departure_time => '20:30',
        arrival_date   => '2011-01-21',
        arrival_time   => '01:20',
    );

    my $timetable = ClubSpain::Model::TimeTable -> new( %params );

    isa_ok($timetable, 'ClubSpain::Model::TimeTable');

    is $timetable -> get_is_published(),   $params{ 'is_published' },   'got is published';
    is $timetable -> get_flight_id(),      $params{ 'flight_id' },      'got flight id';
    is $timetable -> get_departure_date(), $params{ 'departure_date' }, 'got departure date';
    is $timetable -> get_departure_time(), $params{ 'departure_time' }, 'got departure time';
    is $timetable -> get_arrival_date(),   $params{ 'arrival_date' },   'got arrival date';
    is $timetable -> get_arrival_time(),   $params{ 'arrival_time' },   'got arrival time';
    is $timetable -> get_airplane_id(),    $params{ 'airplane_id' },    'got airplane id';

    return;
}

sub test_01_fetch :Test( 10 ) {
    my $self = shift;

    my $timetable = ClubSpain::Model::TimeTable -> fetch_by_id(1);

    isa_ok($timetable, 'ClubSpain::Schema::Result::TimeTable');
    is $timetable -> is_published(),          1, 'got is published flag';
    is $timetable -> flight_id(),             1, 'got flight id';
    is $timetable -> airplane_id(),           3, 'got airplane id';
    is $timetable -> departure_date(),        '2011-02-12', 'got departure date';
    is $timetable -> departure_time(),        '10:00:00', 'got departure time';
    is $timetable -> arrival_date(),          '2011-02-12', 'got arrival date';
    is $timetable -> arrival_time(),          '16:00:00', 'got arrival time';
    is $timetable -> departure_terminal_id(), undef, 'got departure terminal id';
    is $timetable -> arrival_terminal_id(),   undef, 'got arrival terminal id';

    return;
}

sub test_02_fetch :Test( 10 ) {
    my $self = shift;

    my $timetable = ClubSpain::Model::TimeTable->new(
        id                    => 1,
        is_published          => 1,
        flight_id             => 1,
        airplane_id           => 1,
        departure_date        => '2011-01-01',
        departure_time        => '00:00',
        arrival_date          => '2011-01-01',
        arrival_time          => '00:00',
        departure_terminal_id => undef,
        arrival_terminal_id   => undef
    );

    my $object = $timetable -> fetch_by_id();

    isa_ok($object, 'ClubSpain::Schema::Result::TimeTable');

    is $object -> is_published(),   1, 'got is published flag';
    is $object -> flight_id(),      1, 'got flight id';
    is $object -> airplane_id(),    3,'got airplane id';
    is $object -> departure_date(), '2011-02-12', 'got departure date';
    is $object -> departure_time(), '10:00:00', 'got departure time';
    is $object -> arrival_date(),   '2011-02-12', 'got arrival date';
    is $object -> arrival_time(),   '16:00:00', 'got arrival time';
    is $object -> departure_terminal_id(), undef, 'got departure terminal id';
    is $object -> arrival_terminal_id(), undef, 'got arrival terminal id';

    return;
}

sub test_03_fetch_with_exception :Test( 2 ) {
    my $self = shift;

    try {
        ClubSpain::Model::TimeTable -> fetch_by_id( 1000 );
        fail( 'no exception thrown' );

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'caught ClubSpain::Exception::Storage exception' );
        is $e -> message(), 'Couldn\'t find TimeTable: 1000!', 'got message';

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    };

    return;
}

sub test_04_fetch_with_exception :Test( 2 ) {
    my $self = shift;

    try {
        my $timetable = ClubSpain::Model::TimeTable->new(
            id                    => 1000,
            is_published          => 1,
            flight_id             => 1,
            airplane_id           => 1,
            departure_date        => '2011-01-01',
            departure_time        => '00:00',
            arrival_date          => '2011-01-01',
            arrival_time          => '00:00',
            departure_terminal_id => undef,
            arrival_terminal_id   => undef
        );
        $timetable -> fetch_by_id();

        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'caught ClubSpain::Exception::Storage');
        is $e -> message, 'Couldn\'t find TimeTable: 1000!', 'got message';

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    }

    return;
}

sub test_05_create :Test( 22 ) {
    my $self = shift;

    $self -> first_insert();
    $self -> second_insert();

    return;
}

sub first_insert {
    my $self = shift;

    my %params = (
        is_published          => 1,
        is_free               => 1,
        flight_id             => 1,
        airplane_id           => 1,
        departure_date        => '2011-01-21',
        departure_time        => '20:30',
        arrival_date          => '2011-01-22',
        arrival_time          => '01:20',
        departure_terminal_id => undef,
        arrival_terminal_id   => undef
    );

    try {
        my $timetable = ClubSpain::Model::TimeTable -> new( %params );
        my $result    = $timetable -> create();

        isa_ok($result, 'ClubSpain::Schema::Result::TimeTable');

        is $result -> is_published(),          $params{ 'is_published' },          'got is published flag';
        is $result -> is_free(),               $params{ 'is_free' },               'got is free flag';
        is $result -> flight_id(),             $params{ 'flight_id' },             'got flight id';
        is $result -> airplane_id(),           $params{ 'airplane_id' },           'got airplane id';
        is $result -> departure_date(),        $params{ 'departure_date' },        'got departure date';
        is $result -> departure_time(),        $params{ 'departure_time' },        'got departure time';
        is $result -> arrival_date(),          $params{ 'arrival_date' },          'got arrival date';
        is $result -> arrival_time(),          $params{ 'arrival_time' },          'got arrival time';
        is $result -> departure_terminal_id(), $params{ 'departure_terminal_id' }, 'got departure terminal id';
        is $result -> arrival_terminal_id(),   $params{ 'arrival_terminal_id' },   'got arrival terminal id';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub second_insert {
    my $self = shift;

    my %params = (
        is_published          => 1,
        is_free               => 1,
        flight_id             => 2,
        airplane_id           => 1,
        departure_date        => '2011-01-22',
        departure_time        => '05:30',
        arrival_date          => '2011-01-22',
        arrival_time          => '15:20',
        departure_terminal_id => undef,
        arrival_terminal_id   => undef
    );

    try {
        my $timetable = ClubSpain::Model::TimeTable -> new( %params );
        my $result    = $timetable -> create();

        isa_ok($result, 'ClubSpain::Schema::Result::TimeTable');

        is $result -> is_published(),          $params{ 'is_published' },          'got is published flag';
        is $result -> is_free(),               $params{ 'is_free' },               'got is free flag';
        is $result -> flight_id(),             $params{ 'flight_id' },             'got flight id';
        is $result -> airplane_id(),           $params{ 'airplane_id' },           'got airplane id';
        is $result -> departure_date(),        $params{ 'departure_date' },        'got departure date';
        is $result -> departure_time(),        $params{ 'departure_time' },        'got departure time';
        is $result -> arrival_date(),          $params{ 'arrival_date' },          'got arrival date';
        is $result -> arrival_time(),          $params{ 'arrival_time' },          'got arrival time';
        is $result -> departure_terminal_id(), $params{ 'departure_terminal_id' }, 'got departure terminal id';
        is $result -> arrival_terminal_id(),   $params{ 'arrival_terminal_id' },   'got arrival terminal id';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub test_06_update :Test( 12 ) {
    my $self = shift;

    my %params = (
        id                    => 1,
        is_published          => 0,
        is_free               => 1,
        flight_id             => 2,
        airplane_id           => 2,
        departure_date        => '2012-01-01',
        departure_time        => '01:01',
        arrival_date          => '2012-01-01',
        arrival_time          => '02:02',
        departure_terminal_id => undef,
        arrival_terminal_id   => undef,
    );

    try {
        my $timetable = ClubSpain::Model::TimeTable -> new( %params );

        my $result = $timetable -> update();

        isa_ok($result, 'ClubSpain::Schema::Result::TimeTable');
        is $result -> id,                    $params{ 'id' },                    'got id';
        is $result -> is_published,          $params{ 'is_published' },          'got is published flag';
        is $result -> is_free,               $params{ 'is_free' },               'got is free flag';
        is $result -> flight_id,             $params{ 'flight_id' },             'got flight id';
        is $result -> airplane_id,           $params{ 'airplane_id' },           'got airplane id';
        is $result -> departure_date,        $params{ 'departure_date' },        'got departure date';
        is $result -> departure_time,        $params{ 'departure_time' },        'got departure time';
        is $result -> arrival_date,          $params{ 'arrival_date' },          'got arrival date';
        is $result -> arrival_time,          $params{ 'arrival_time' },          'got arrival time';
        is $result -> departure_terminal_id, $params{ 'departure_terminal_id' }, 'got terminal id';
        is $result -> arrival_terminal_id,   $params{ 'arrival_terminal_id' },   'got arrival terminal id';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    }

    return;
}

sub test_07_update_call_as_class_method :Test() {
    my $self = shift;

    try {
        ClubSpain::Model::TimeTable -> update();
        fail( 'no exception thrown' );

    } catch( ClubSpain::Exception::Argument $e ) {
        pass( 'caught ClubSpain::Exception::Argument exception' );

    } catch( $error ) {
        fail( 'caught other error' );
        diag $error;
    }

    return;
}

sub test_08_update_non_existed_object :Test() {
    my $self = shift;

    try {
        my $timetable = ClubSpain::Model::TimeTable->new(
            id                    => 777,
            is_published          => 0,
            flight_id             => 2,
            airplane_id           => 2,
            departure_date        => '2012-01-01',
            departure_time        => '01:01',
            arrival_date          => '2012-01-01',
            arrival_time          => '02:02',
            departure_terminal_id => undef,
            arrival_terminal_id   => undef,
        );
        $timetable -> update();

        fail( 'no exception thrown' );

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'pass caught ClubSpain::Exception::Storage exception' );

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    }

    return;
}

sub test_09_delete_with_exception :Test {
    my $self = shift;

    try {
        ClubSpain::Model::TimeTable -> delete(1000);
        fail( 'no exception thrown' );

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'Class method: caught Storage exception' );

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    };

    return;
}

sub test_10_delete_with_exeption :Test {
    my $self = shift;

    try {
        my $timetable = ClubSpain::Model::TimeTable->new(
            id                    => 777,
            is_published          => 0,
            flight_id             => 2,
            airplane_id           => 2,
            departure_date        => '2012-01-01',
            departure_time        => '01:01',
            arrival_date          => '2012-01-01',
            arrival_time          => '02:02',
            departure_terminal_id => undef,
            arrival_terminal_id   => undef,
        );
        $timetable -> delete();

        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass('Object Method: caught Storage exception');

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    };

    return;
}

sub test_11_delete :Test( 12 ) {
    my $self = shift;

    my $schema = $self -> { 'schema' } -> schema();
    my $count = $schema -> resultset( 'TimeTable' ) -> search({}) -> count();

    my $timetable = ClubSpain::Model::TimeTable -> new(
        is_published      => 1,
        is_free           => 1,
        flight_id         => 1,
        airplane_id       => 1,
        departure_date    => '2012-01-21',
        departure_time    => '20:30',
        arrival_date      => '2012-01-22',
        arrival_time      => '01:20',
        departure_terminal_id => undef,
        arrival_terminal_id   => undef
    );

    my $object = $timetable -> create();

    isa_ok($object, 'ClubSpain::Schema::Result::TimeTable');
    is $object -> is_published,   1, 'got is published flag';
    is $object -> is_free,        1, 'got is free flag';
    is $object -> flight_id,      1, 'got flight id';
    is $object -> airplane_id,    1, 'got airplane id';
    is $object -> departure_date, '2012-01-21', 'got departure date';
    is $object -> departure_time, '20:30',      'got departure time';
    is $object -> arrival_date,   '2012-01-22', 'got arrival date';
    is $object -> arrival_time,   '01:20',      'got arrival time';
    is $object -> departure_terminal_id, undef, 'got departure terminal id';
    is $object -> arrival_terminal_id, undef,   'got arrival terminal id';

    ClubSpain::Model::TimeTable -> delete( $object -> id() );

    my $rs = $schema -> resultset( 'TimeTable' ) -> search({});
    is $rs -> count(), $count, 'no objects left';

    return;
}

1;

__END__