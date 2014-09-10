package ClubSpain::Test::Model::Manufacturer;

use strict;
use warnings;

use ClubSpain::Model::Manufacturer;

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

sub test_00_simple :Test(3) {
    my $self = shift;

    my $producer = ClubSpain::Model::Manufacturer -> new(
        code    => 'code',
        name    => 'name',
    );

    isa_ok( $producer, 'ClubSpain::Model::Manufacturer' );
    is $producer -> get_code, 'code', 'got manufacturer code';
    is $producer -> get_name, 'name', 'got manufacturer name';

    return;
}

sub test_01_fetch :Test(3) {
    my $self = shift;

    my $manufacturer = ClubSpain::Model::Manufacturer -> fetch_by_id(2);

    isa_ok($manufacturer, 'ClubSpain::Schema::Result::Manufacturer');
    is $manufacturer -> code(), 'AIRBUS', 'got  code';
    is $manufacturer -> name(), 'Airbus SAS', 'got name';

    return;
}

sub test_02_fetch :Test(3) {
    my $manufacturer = ClubSpain::Model::Manufacturer -> new(
        id          => 2,
        code        => 'code',
        name        => 'name',
    );

    my $object = $manufacturer -> fetch_by_id();

    isa_ok($object, 'ClubSpain::Schema::Result::Manufacturer');
    is $object -> code(), 'AIRBUS', 'got  code';
    is $object -> name(), 'Airbus SAS', 'got name';

    return;
}

sub test_03_fetch_with_exception :Test {
    my $self = shift;

    try {
        ClubSpain::Model::Manufacturer -> fetch_by_id(1000);
        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'caught ClubSpain::Exception::Storage exception' );

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    };

    return;
}

sub test_04_fetch_with_exception :Test(2) {
    my $self = shift;

    try {
        my $manufacturer = ClubSpain::Model::Manufacturer -> new(
            id          => 1000,
            code        => 'code',
            name        => 'name',
        );
        $manufacturer -> fetch_by_id();

        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'caught ClubSpain::Exception::Storage');
        is $e -> message, 'Couldn\'t find Manufacturer: 1000!', 'got message';

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    };

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

    try {
        my $producer = ClubSpain::Model::Manufacturer -> new(
            code    => 'xxx',
            name    => 'xxx xxxx',
        );
        my $result = $producer -> create();

        pass( 'no exception thrown' );

        isa_ok $result, 'ClubSpain::Schema::Result::Manufacturer';
        is $result -> code, 'xxx', 'got code';
        is $result -> name, 'xxx xxxx', 'got name';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub second_insert {
    my $self = shift;

    try {
        my $producer = ClubSpain::Model::Manufacturer->new(
            code    => 'yyy',
            name    => 'yyy yyyy',
        );
        my $result = $producer -> create();

        pass('no exception thrown');

        isa_ok($result, 'ClubSpain::Schema::Result::Manufacturer');
        is $result -> code, 'yyy', 'got icao code';
        is $result -> name, 'yyy yyyy', 'got name';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub test_06_update :Test( 6 ) {
    my $self = shift;

    try {
        my $manufacturer = ClubSpain::Model::Manufacturer -> new(
            id           => 1,
            code         => 'cccc',
            name         => 'New manufacturer name',
            is_published => 0,
        );

        my $result = $manufacturer -> update();

        pass( 'no exception thrown' );

        isa_ok $result, 'ClubSpain::Schema::Result::Manufacturer';
        is $result -> id, 1, 'got id';
        is $result -> code, 'cccc', 'got code';
        is $result -> name, 'New manufacturer name', 'got name';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub test_07_update_call_as_class_method :Test() {
    my $self = shift;

    try {
        ClubSpain::Model::Manufacturer -> update();
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
        my $manufacturer = ClubSpain::Model::Manufacturer -> new(
            id      => 1000,
            code    => 'code',
            name    => 'name',
        );
        $manufacturer -> update();

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
        ClubSpain::Model::Manufacturer -> delete(1000);
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
        my $manufacturer = ClubSpain::Model::Manufacturer -> new(
            id      => 1000,
            code    => 'code',
            name    => 'name',
        );
        $manufacturer -> delete();

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
    my $count = $schema -> resultset( 'Manufacturer' ) -> search({}) -> count();

    my $manufacturer = ClubSpain::Model::Manufacturer->new(
        code    => 'xyz',
        name    => 'xyz xxxx',
    );

    my $object = $manufacturer -> create();

    isa_ok($object, 'ClubSpain::Schema::Result::Manufacturer');
    is $object -> code, 'xyz', 'got code';
    is $object -> name, 'xyz xxxx', 'got name';

    ClubSpain::Model::Manufacturer -> delete( $object -> id() );

    my $rs = $schema -> resultset( 'Manufacturer' ) -> search({});
    is $rs -> count(), $count, 'no objects left';

    return;
}

1;