package ClubSpain::Test::Model::Airport;

use strict;
use warnings;

use ClubSpain::Model::Airport;

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

    my $port = ClubSpain::Model::Airport -> new(
        iata         => 'dme',
        icao         => 'uudm',
        name         => 'Domodedovo',
        city_id      => 1,
        is_published => 1,
    );

    isa_ok($port, 'ClubSpain::Model::Airport');
    is $port -> get_city_id(), 1, 'got city_id';
    is $port -> get_iata(), 'dme', 'got iata code';
    is $port -> get_icao(), 'uudm', 'got icao code';
    is $port -> get_name(), 'Domodedovo', 'got name';
    is $port -> get_is_published(), 1, 'got is_published';

    return;
}

sub test_01_fetch :Test(6) {
    my $self = shift;

    my $port = ClubSpain::Model::Airport -> fetch_by_id(1);

    isa_ok($port, 'ClubSpain::Schema::Result::Airport');
    is $port -> city_id(), 1, 'got city id';
    is $port -> iata(), 'DME', 'got iata code';
    is $port -> icao(), 'UUDD', 'got icao code';
    is $port -> name(), 'Domodedovo', 'got header';
    is $port -> is_published(), 1, 'got is published';

    return;
}

sub test_02_fetch :Test(6) {
    my $self = shift;

    my $port = ClubSpain::Model::Airport -> new(
        id           => 1,
        iata         => 'iat',
        icao         => 'icao',
        name         => 'name',
        city_id      => 1,
        is_published => 0,
    );

    my $object = $port->fetch_by_id();

    isa_ok($object, 'ClubSpain::Schema::Result::Airport');
    is $object -> city_id(), 1, 'got city id';
    is $object -> iata(), 'DME', 'got iata';
    is $object -> icao(), 'UUDD', 'got icao';
    is $object -> name(), 'Domodedovo', 'got name';
    is $object -> is_published(), 1, 'got is published';

    return;
}

sub test_03_fetch_with_exception :Test(2) {
    my $self = shift;

    try {
        ClubSpain::Model::Airport->fetch_by_id(1000);
        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'caught ClubSpain::Exception::Storage' );
        is $e -> message, 'Couldn\'t find Airport: 1000!', 'got message';

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    };

    return;
}

sub test_04_fetch_with_exception :Test(2) {
    my $self = shift;

    try {
        my $port = ClubSpain::Model::Airport->new(
            id           => 1000,
            iata         => 'xxx',
            icao         => 'xxxx',
            name         => 'name',
            city_id      => 1,
            is_published => 1,
        );

        $port -> fetch_by_id();
        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'caught ClubSpain::Exception::Storage' );
        is $e -> message, 'Couldn\'t find Airport: 1000!', 'got message';

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    };

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
        my $port = ClubSpain::Model::Airport -> new(
            iata         => 'xxx',
            icao         => 'xxxx',
            name         => 'xxx xxxx',
            city_id      => 1,
            is_published => 1,
        );
        my $result = $port->create();

        pass('no exception thrown');
        isa_ok( $result, 'ClubSpain::Schema::Result::Airport' );
        is $result -> city_id(), 1, 'got city id';
        is $result -> iata(), 'xxx', 'got iata code';
        is $result -> icao(), 'xxxx', 'got icao code';
        is $result -> name(), 'xxx xxxx', 'got name';
        is $result -> is_published(), 1, 'got is_published';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub second_create {
    my $self = shift;

    try {
        my $port = ClubSpain::Model::Airport -> new(
            iata         => 'yyy',
            icao         => 'yyyy',
            name         => 'yyy yyyy',
            city_id      => 1,
            is_published => 1,
        );
        my $result = $port -> create();
        pass('no exception thrown');

        isa_ok( $result, 'ClubSpain::Schema::Result::Airport' );
        is $result -> city_id(), 1, 'got city id';
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

    my $port = ClubSpain::Model::Airport->new(
        id           => 1,
        iata         => 'zzz',
        icao         => 'cccc',
        name         => 'New Airport name',
        city_id      => 2,
        is_published => 0,
    );

    my $result = $port->update();

    isa_ok( $result, 'ClubSpain::Schema::Result::Airport' );
    is $result -> id, 1, 'got id';
    is $result -> city_id, 2, 'got city id';
    is $result -> iata, 'zzz', 'got iata code';
    is $result -> icao, 'cccc', 'got icao code';
    is $result -> name, 'New Airport name', 'got name';
    is $result -> is_published, 0, 'got is_published';

    return;
}

sub test_07_update_call_as_class_method :Test() {
    my $self = shift;

    try {
        ClubSpain::Model::Airport -> update();
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
        my $port = ClubSpain::Model::Airport -> new(
            id           => 777,
            iata         => 'xxx',
            icao         => 'uudx',
            name         => 'name',
            city_id      => 100,
            is_published => 1,
        );

        $port -> update();
        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass('caught Storage exception');

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    };

    return;
}

sub test_09_delete_with_exception :Test {
    my $self = shift;

    try {
        ClubSpain::Model::Airport -> delete(1000);
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
        my $port = ClubSpain::Model::Airport -> new(
            id           => 100,
            iata         => 'bar',
            icao         => 'barx',
            name         => 'foo bar',
            city_id      => 1,
            is_published => 0,
        );

        $port -> delete();
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

    my $schema = $self -> { 'schema' } -> schema;

    my $count = $schema -> resultset( 'Airport' ) -> search({}) -> count();

    my $port = ClubSpain::Model::Airport->new(
        iata         => 'xxy',
        icao         => 'xxyy',
        name         => 'xxx xxxx',
        city_id      => 1,
        is_published => 0,
    );

    my $object = $port -> create();

    isa_ok($object, 'ClubSpain::Schema::Result::Airport');
    is $object -> city_id, 1, 'got city id';
    is $object -> iata, 'xxy', 'got iata code';
    is $object -> icao, 'xxyy', 'got icao code';
    is $object -> name, 'xxx xxxx', 'got name';
    is $object -> is_published, 0, 'got is published';

    ClubSpain::Model::Airport -> delete( $object -> id() );

    my $rs = $schema -> resultset( 'Airport' ) -> search({});
    is( $rs -> count(), $count, 'no objects left' );

    return;
}

1;

__END__