package ClubSpain::Test::Model::Flight;

use strict;
use warnings;

use ClubSpain::Model::Flight;

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

sub test_00_simple :Test(6) {
    my $self = shift;

    my $flight = ClubSpain::Model::Flight->new(
        is_published         => 1,
        airport_of_departure => 1,
        airport_of_arrival   => 2,
        airline_id           => 1,
        code                 => 331,
    );

    isa_ok($flight, 'ClubSpain::Model::Flight');

    is $flight -> get_is_published, 1, 'got is published flag';
    is $flight -> get_airport_of_departure, 1, 'got departure airport id';
    is $flight -> get_airport_of_arrival, 2, 'got destination airport id';
    is $flight -> get_airline_id, 1, 'got airline';
    is $flight -> get_code, 331, 'got code';

    return;
}

sub test_01_fetch :Test(6) {
    my $self = shift;

    my $flight = ClubSpain::Model::Flight -> fetch_by_id(1);

    isa_ok($flight, 'ClubSpain::Schema::Result::Flight');
    is $flight -> is_published, 1, 'got is_published';
    is $flight -> departure_airport_id, 1, 'geo departure airport';
    is $flight -> destination_airport_id, 4, 'got destination airport';
    is $flight -> airline_id, 1, 'got airline';
    is $flight -> code, 331, 'got code';

    return;
}

sub test_02_fetch :Test(6) {
    my $self = shift;

    my $flight = ClubSpain::Model::Flight -> new(
        id                   => 2,
        is_published         => 1,
        airport_of_departure => 0,
        airport_of_arrival   => 0,
        airline_id           => 0,
        code                 => 111,
    );

    my $object = $flight->fetch_by_id();

    isa_ok($object, 'ClubSpain::Schema::Result::Flight');
    is $object -> is_published, 1, 'got is_published';
    is $object -> departure_airport_id, 4, 'got departure airport';
    is $object -> destination_airport_id, 1, 'got destination airport';
    is $object -> airline_id, 1, 'got airline';
    is $object -> code, 332, 'got code';

    return;
}

sub test_03_fetch_with_exception :Test(2) {
    my $self = shift;

    try {
        ClubSpain::Model::Flight -> fetch_by_id(1000);
        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'caught ClubSpain::Exception::Storage exception' );
        is $e -> message, 'Couldn\'t find Flight: 1000!', 'got message';

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    };

    return;
}

sub test_04_fetch_with_exception :Test( 2 ) {
    my $self = shift;

    try {
        my $flight = ClubSpain::Model::Flight -> new(
            id                   => 1000,
            is_published         => 1,
            airport_of_departure => 0,
            airport_of_arrival   => 0,
            airline_id           => 0,
            code                 => 111,
        );
        $flight -> fetch_by_id();

        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'caught ClubSpain::Exception::Storage');
        is $e -> message, 'Couldn\'t find Flight: 1000!', 'got message';

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    }

    return;
}

sub test_05_create :Test(14) {
    my $self = shift;

    $self -> first_create();
    $self -> second_create();

    return;
}

sub first_create {
    my $self = shift;

    try {
        my $flight = ClubSpain::Model::Flight -> new(
            is_published         => 1,
            airport_of_departure => 1,
            airport_of_arrival   => 2,
            airline_id           => 1,
            code                 => 8331,
        );

        my $result = $flight -> create();

        pass('no exception thrown');

        isa_ok($result, 'ClubSpain::Schema::Result::Flight');
        is $result -> is_published, 1, 'got is_published flag';
        is $result -> departure_airport_id, 1, 'got departure airport';
        is $result -> destination_airport_id, 2, 'got destination airport';
        is $result -> airline_id, 1, 'got airline';
        is $result -> code, 8331, 'got code';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    }


    return;
}

sub second_create {
    my $self = shift;

    try {
        my $flight = ClubSpain::Model::Flight -> new(
            is_published         => 1,
            airport_of_departure => 2,
            airport_of_arrival   => 1,
            airline_id           => 1,
            code                 => 8332,
        );

        my $result = $flight -> create();
        pass('no exception thrown');

        isa_ok($result, 'ClubSpain::Schema::Result::Flight');
        is $result -> is_published, 1, 'got is_published flag';
        is $result -> departure_airport_id, 2, 'got departure airport';
        is $result -> destination_airport_id, 1, 'got destination airport';
        is $result -> airline_id, 1, 'got airline';
        is $result -> code, 8332, 'got code';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub test_06_update :Test(7) {
    my $self = shift;

    my $flight = ClubSpain::Model::Flight->new(
        id                   => 1,
        is_published         => 0,
        airport_of_departure => 2,
        airport_of_arrival   => 3,
        airline_id           => 2,
        code                 => 321,
    );

    my $result = $flight -> update();

    isa_ok($result, 'ClubSpain::Schema::Result::Flight');
    is $result -> id, 1, 'got id';
    is $result -> is_published, 0, 'got is published';
    is $result -> departure_airport_id, 2, 'got departure airport';
    is $result -> destination_airport_id, 3, 'got destination airport';
    is $result -> airline_id, 2, 'got airline';
    is $result -> code, 321, 'got code';

    return;
}

sub test_07_update_call_as_class_method :Test() {
    my $self = shift;

    try {
        ClubSpain::Model::Flight -> update();
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
        my $flight = ClubSpain::Model::Flight -> new(
            id                   => 1000,
            is_published         => 1,
            airport_of_departure => 0,
            airport_of_arrival   => 0,
            airline_id           => 0,
            code                 => 111,
        );
        $flight -> update();

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
        ClubSpain::Model::Flight -> delete(1000);
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
        my $flight = ClubSpain::Model::Flight -> new(
            id                   => 1000,
            is_published         => 1,
            airport_of_departure => 0,
            airport_of_arrival   => 0,
            airline_id           => 0,
            code                 => 111,
        );
        $flight -> delete();

        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass('Object Method: caught Storage exception');

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    };

    return;
}

sub test_11_delete :Test(7) {
    my $self = shift;

    my $schema = $self -> { 'schema' } -> schema();
    my $count  = $schema -> resultset( 'Flight' ) -> search({}) -> count();

    my $flight = ClubSpain::Model::Flight -> new(
        is_published         => 1,
        airport_of_departure => 1,
        airport_of_arrival   => 2,
        airline_id           => 1,
        code                 => 337,
    );

    my $object = $flight -> create();

    isa_ok( $object, 'ClubSpain::Schema::Result::Flight' );
    is $object -> is_published, 1, 'got is published';
    is $object -> departure_airport_id, 1, 'got departure airport';
    is $object -> destination_airport_id, 2, 'got destination airport';
    is $object -> airline_id, 1, 'got airline';
    is $object -> code, 337, 'got is code';

    ClubSpain::Model::Flight -> delete( $object -> id() );

    my $rs = $schema -> resultset( 'Flight' ) -> search({});
    is $rs -> count(), $count, 'no objects left';

    return;
}


1;