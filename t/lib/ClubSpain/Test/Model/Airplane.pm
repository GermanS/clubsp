package ClubSpain::Test::Model::Airplane;

use strict;
use warnings;

use ClubSpain::Model::Airplane;

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

    my $airplane = ClubSpain::Model::Airplane -> new(
        iata            => '310',
        icao            => 'A310',
        name            => 'A310',
        manufacturer_id => 1,
        is_published    => 1,
    );

    isa_ok($airplane, 'ClubSpain::Model::Airplane');
    is $airplane -> get_manufacturer_id(), 1,  'got manufacturer';
    is $airplane -> get_iata(),         '310',  'got iata code';
    is $airplane -> get_icao(),         'A310', 'got icao code';
    is $airplane -> get_name(),         'A310', 'got name';
    is $airplane -> get_is_published(), 1,      'got is published';

    return;
}

sub test_01_fetch :Test(6) {
    my $self = shift;

    my $airplane = ClubSpain::Model::Airplane -> fetch_by_id(1);
    isa_ok($airplane, 'ClubSpain::Schema::Result::Airplane');
    is $airplane -> manufacturer_id(), 2, 'got manufacturer code';
    is $airplane -> iata(),         '318',  'got iata code';
    is $airplane -> icao(),         'A318', 'got icao code';
    is $airplane -> name(),         'A318', 'got name';
    is $airplane -> is_published(), 1,      'got is published';

    return;
}

sub test_02_fetch :Test(5) {
    my $self = shift;

    my $airline = ClubSpain::Model::Airline -> new(
        id           => 1,
        iata         => 'xx',
        icao         => 'xxx',
        name         => 'name',
        is_published => 0,
    );

    my $object = $airline -> fetch_by_id();
    isa_ok($object, 'ClubSpain::Schema::Result::Airline');
    is $object -> iata(), 'NN', 'got iata';
    is $object -> icao(), 'MOV', 'got icao';
    is $object -> name(), 'VIM Airlines', 'got name';
    is $object -> is_published(), 1, 'got is published';

    return;
}

sub test_03_fetch_with_exception : Test(2) {
    my $self = shift;

    try {
        ClubSpain::Model::Airline -> fetch_by_id(1000);
        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'caught ClubSpain::Exception::Storage' );
        is $e -> message(), 'Couldn\'t find Airline: 1000!', 'got message';

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    };

    return;
}

sub test_04_fetch :Test(2) {
    my $self = shift;

    try {
        my $airline = ClubSpain::Model::Airline -> new(
            id           => 1000,
            iata         => 'xx',
            icao         => 'xxx',
            name         => 'name',
            is_published => 1,
        );

        $airline -> fetch_by_id();
        fail( 'no exception thrown' );

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'caught ClubSpain::Exception::Storage' );
        is $e -> message, 'Couldn\'t find Airline: 1000!', 'got message';

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    };

    return;
}

sub test_05_create :Test(14) {
    my $self = shift;

    $self -> first_insert();
    $self -> second_insert();

    return;
}

sub first_insert {
    my $self = shift;

    try {
        my $airplane = ClubSpain::Model::Airplane -> new(
            iata            => 'xxx',
            icao            => 'xxxx',
            name            => 'xxx xxxx',
            manufacturer_id => 1,
            is_published    => 1,
        );

        my $result = $airplane -> create();
        pass('no exception thrown');

        isa_ok($result, 'ClubSpain::Schema::Result::Airplane');
        is $result -> manufacturer_id(), 1, 'got manufacturer id';
        is $result -> iata(), 'xxx',  'got iata code';
        is $result -> icao(), 'xxxx', 'got icao code';
        is $result -> name(), 'xxx xxxx', 'got name';
        is $result -> is_published(), 1,  'got is_published';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    }

    return;
}

sub second_insert {
    my $self = shift;

    try {
        my $airplane = ClubSpain::Model::Airplane -> new(
            iata            => 'yyy',
            icao            => 'yyyy',
            name            => 'yyy yyyy',
            manufacturer_id => 1,
            is_published    => 1,
        );

        my $result = $airplane -> create();
        pass( 'no exception thrown' );

        isa_ok($result, 'ClubSpain::Schema::Result::Airplane');
        is $result -> manufacturer_id(), 1, 'got manufacturer id';
        is $result -> iata(), 'yyy', 'got iata code';
        is $result -> icao(), 'yyyy', 'got icao code';
        is $result -> name(), 'yyy yyyy', 'got name';
        is $result -> is_published(), 1, 'got is_published';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub test_06_update :Test(7) {
    my $self = shift;

    my $airplane = ClubSpain::Model::Airplane -> new(
        id              => 1,
        iata            => 'zzz',
        icao            => 'cccc',
        name            => 'New Airplane name',
        manufacturer_id => 1,
        is_published    => 0,
    );

    my $result = $airplane -> update();

    isa_ok($result, 'ClubSpain::Schema::Result::Airplane');
    is $result -> id(), 1, 'got id';
    is $result -> manufacturer_id(), 1, 'got manufacturer code';
    is $result -> iata(), 'zzz', 'got iata code';
    is $result -> icao(), 'cccc', 'got icao code';
    is $result -> name(), 'New Airplane name', 'got name';
    is $result -> is_published(), 0, 'got is_published';

    return;
}

sub test_07_update_call_as_class_method :Test() {
    my $self = shift;

    try {
        ClubSpain::Model::Airplane -> update();
        fail('no exception thrown');

    } catch( ClubSpain::Exception::Argument $e ) {
        pass( 'caught ClubSpain::Exception::Argument exception' );

    } catch( $error ) {
        fail( 'caught other error' );
        diag $error;
    }

    return;
}

sub test_08_update_non_existed_object :Test {
    my $self = shift;

    try {
        my $airplane = ClubSpain::Model::Airplane->new(
            id              => 777,
            iata            => 'xxx',
            icao            => 'udxx',
            name            => 'name',
            manufacturer_id => 1,
            is_published    => 1,
        );

        $airplane -> update();

        fail( 'no exception thrown' );
    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'caught ClubSpain::Exception::Storage exception' );

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    };

    return;
}

sub test_09_delete_with_exception :Test {
    my $self = shift;

    try {
        ClubSpain::Model::Airplane -> delete(1000);
        fail( 'no exception thrown' );

    } catch( ClubSpain::Exception::Storage $e ) {
        pass('Class method: caught Storage exception');

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    };

    return;
}

sub test_10_delete_with_exception :Test {
    my $self = shift;

    try {
        my $airplane = ClubSpain::Model::Airplane -> new(
            id              => 23,
            iata            => 'foo',
            icao            => 'barx',
            name            => 'foo barx',
            manufacturer_id => 1,
            is_published    => 0,
        );

        $airplane -> delete();
        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass('Object Method: caught Storage exception');

    } catch( $error ) {
        fail( 'cought other exception' );
        diag $error;
    }

    return;
}

sub test_11_delete :Test(7) {
    my $self = shift;

    my $schema = $self -> { 'schema' } -> schema;

    my $count = $schema -> resultset( 'Airplane' ) -> search({}) -> count();

    my $airplane = ClubSpain::Model::Airplane->new(
        iata            => '744',
        icao            => 'b744',
        name            => '747-400',
        manufacturer_id => 1,
        is_published    => 0,
    );

    my $object = $airplane->create();

    isa_ok($object, 'ClubSpain::Schema::Result::Airplane');
    is $object -> manufacturer_id(), 1, 'got manufacturer code';
    is $object -> iata(), '744', 'got iata code';
    is $object -> icao(), 'b744', 'got icao code';
    is $object -> name(), '747-400', 'got name';
    is $object -> is_published(), 0, 'got is published';

    ClubSpain::Model::Airplane -> delete( $object -> id() );

    my $rs = $schema -> resultset( 'Airplane' ) -> search({});
    is( $rs -> count(), $count, 'no objects left');

    return;
}

1;

__END__