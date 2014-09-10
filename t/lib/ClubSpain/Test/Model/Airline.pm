package ClubSpain::Test::Model::Airline;

use strict;
use warnings;

use ClubSpain::Model::Airline;

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

sub test_00_simple :Test( 5 ) {
    my $self = shift;

    my $airline = ClubSpain::Model::Airline -> new(
        iata         => 'S7',
        icao         => 'SBI',
        name         => 'S7 Airlines',
        is_published => 1,
    );

    isa_ok($airline, 'ClubSpain::Model::Airline');
    is $airline -> get_iata(), 'S7', 'got iata code';
    is $airline -> get_icao(), 'SBI', 'got icao code';
    is $airline -> get_name(), 'S7 Airlines', 'got name';
    is $airline -> get_is_published(), 1, 'got is published';

    return;
}

sub test_01_fetch :Test(5) {
    my $self = shift;

    my $airline = ClubSpain::Model::Airline -> fetch_by_id(1);

    isa_ok($airline, 'ClubSpain::Schema::Result::Airline');
    is $airline -> iata(), 'NN', 'got iata code';
    is $airline -> icao(), 'MOV', 'got icao code';
    is $airline -> name(), 'VIM Airlines', 'got name';
    is $airline -> is_published(), 1, 'got is published';

    return;
}

sub test_02_fetch :Test(5) {
    my $self = shift;

    my $airline = ClubSpain::Model::Airline->new(
        id           => 1,
        iata         => 'xx',
        icao         => 'xxx',
        name         => 'name',
        is_published => 0,
    );

    my $object = $airline -> fetch_by_id();

    isa_ok($object, 'ClubSpain::Schema::Result::Airline');
    is $object -> iata(), 'NN', 'got iata';
    is $object -> icao(), 'MOV','got icao';
    is $object -> name(), 'VIM Airlines', 'got name';
    is $object -> is_published(), 1, 'got is published';

    return;
}

sub test_03_fetch_with_exception :Test {
    my $self = shift;

    try {
        ClubSpain::Model::Airline -> fetch_by_id(1000);
        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'caught ClubSpain::Exception::Storage exception' );

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    };

    return;
}

sub test_04_fetch_with_exception :Test( 2 ) {
    my $self = shift;

    try {
        my $airline = ClubSpain::Model::Airline->new(
            id           => 1000,
            iata         => 'xx',
            icao         => 'xxx',
            name         => 'name',
            is_published => 1,
        );
        $airline -> fetch_by_id();

        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'caught ClubSpain::Exception::Storage');
        is $e -> message, 'Couldn\'t find Airline: 1000!', 'got message';

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    }

    return;
}

sub test_05_create :Test( 10 ) {
    my $self = shift;

    $self -> first_insert();
    $self -> second_insert();

    return;
}

sub first_insert {
    my $self = shift;

    my $airline = ClubSpain::Model::Airline -> new(
        iata         => 'xx',
        icao         => 'xxx',
        name         => 'xx xxx',
        is_published => 1,
    );

    try {
        my $result = $airline -> create();

        isa_ok($result, 'ClubSpain::Schema::Result::Airline');

        is $result -> iata(), 'xx', 'got iata code';
        is $result -> icao(), 'xxx', 'got icao code';
        is $result -> name(), 'xx xxx', 'got name';
        is $result -> is_published(), 1, 'got is_published';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub second_insert {
    my $self = shift;

    try {
        my $airline = ClubSpain::Model::Airline -> new(
            iata         => 'yy',
            icao         => 'yyy',
            name         => 'yy yyy',
            is_published => 1,
        );

        my $result = $airline -> create();

        isa_ok($result, 'ClubSpain::Schema::Result::Airline');
        is $result -> iata(), 'yy', 'got iata code';
        is $result -> icao(), 'yyy', 'got icao code';
        is $result -> name(), 'yy yyy', 'got name';
        is $result -> is_published(), 1,'got is_published';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub test_06_update :Test(6) {
    my $self = shift;

    try {
        my $airline = ClubSpain::Model::Airline -> new(
            id           => 1,
            iata         => 'zz',
            icao         => 'ccc',
            name         => 'New Airline name',
            is_published => 0,
        );

        my $result = $airline -> update();

        isa_ok($result, 'ClubSpain::Schema::Result::Airline');
        is $result -> id(), 1, 'got id';
        is $result -> iata(), 'zz', 'got iata code';
        is $result -> icao(), 'ccc','got icao code';
        is $result -> name(), 'New Airline name', 'got name';
        is $result -> is_published(), 0,'got is_published';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    }

    return;
}

sub test_07_update_call_as_class_method :Test() {
    my $self = shift;

    try {
        ClubSpain::Model::Airline -> update();
        fail('no exception thrown');

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
        my $airline = ClubSpain::Model::Airline -> new(
            id           => 777,
            iata         => 'xx',
            icao         => 'udx',
            airline      => 'name',
            is_published => 1,
        );

        $airline -> update();
        fail('no exception thrown');

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
        ClubSpain::Model::Airline -> delete(1000);
        fail( 'no exception thrown' );

    } catch( ClubSpain::Exception::Storage $e ) {
        pass('Class method: caught Storage exception');

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    };

    return;
}

sub test_10_delete_with_exeption :Test {
    my $self = shift;

    try {
        my $airline = ClubSpain::Model::Airline -> new(
            id           => 23,
            iata         => 'fo',
            icao         => 'bar',
            name         => 'fo bar',
            is_published => 0,
        );

        $airline -> delete();
        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass('Object Method: caught Storage exception');

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    };

    return;
}

sub test_11_delete :Test( 6 ) {
    my $self = shift;

    my $schema = $self -> { 'schema' } -> schema();
    my $count = $schema -> resultset('Airline') -> search({}) -> count();

    my $airline = ClubSpain::Model::Airline -> new(
        iata         => 'SU',
        icao         => 'AFL',
        name         => 'AeroFlot',
        is_published => 0,
    );

    my $object = $airline -> create();

    isa_ok($object, 'ClubSpain::Schema::Result::Airline');
    is $object -> iata(),        'SU',       'got iata code';
    is $object -> icao(),        'AFL',      'got icao code';
    is $object -> name(),        'AeroFlot', 'got name';
    is $object -> is_published(), 0,         'got is published';


    ClubSpain::Model::Airline -> delete( $object -> id() );

    my $rs = $schema -> resultset( 'Airline' ) -> search({});
    is $rs -> count(), $count, 'no objects left';

    return;
}

1;