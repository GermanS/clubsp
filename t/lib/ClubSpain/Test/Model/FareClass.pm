package ClubSpain::Test::Model::FareClass;

use strict;
use warnings;

use ClubSpain::Model::FareClass;

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

sub test_00_simple :Test(4) {
    my $self = shift;

    my $class = ClubSpain::Model::FareClass -> new(
        code        => 'B',
        name        => 'Full fare economy class',
        is_published => 1,
    );

    isa_ok($class, 'ClubSpain::Model::FareClass');

    is $class -> get_code(), 'B', 'got code';
    is $class -> get_name(), 'Full fare economy class', 'got name';
    is $class -> get_is_published(), 1, 'got is published';

    return;
}

sub test_01_fetch :Test(4) {
    my $self = shift;

    my $fareclass = ClubSpain::Model::FareClass -> fetch_by_id(1);

    isa_ok($fareclass, 'ClubSpain::Schema::Result::FareClass');
    is $fareclass -> code, 'Y', 'got code';
    is $fareclass -> name, 'Economy', 'got name';
    is $fareclass -> is_published, 1, 'got is published';

    return;
}

sub test_02_fetch :Test(4) {
    my $self = shift;

    my $fareclass = ClubSpain::Model::FareClass->new(
        id           => 1,
        code         => 'x',
        name         => 'name',
        is_published => 0,
    );

    my $object = $fareclass -> fetch_by_id();

    isa_ok($object, 'ClubSpain::Schema::Result::FareClass');
    is $object -> code(), 'Y', 'got code';
    is $object -> name(), 'Economy', 'got name';
    is $object -> is_published(), 1, 'got is published';

    return;
}

sub test_03_fetch_with_exception :Test {
    my $self = shift;

    try {
        ClubSpain::Model::FareClass -> fetch_by_id(1000);
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
        my $fareclass = ClubSpain::Model::FareClass->new(
            id           => 1000,
            code         => 'x',
            name         => 'name',
            is_published => 0,
        );

        $fareclass -> fetch_by_id();

        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'caught ClubSpain::Exception::Storage');
        is $e -> message, 'Couldn\'t find FareClass: 1000!', 'got message';

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

    try {
        my $fareclass = ClubSpain::Model::FareClass->new(
            code    => 'x',
            name    => 'name',
            is_published => 1,
        );
        my $result = $fareclass->create();

        pass('no exception thrown');

        isa_ok($result, 'ClubSpain::Schema::Result::FareClass');
        is $result -> code, 'x', 'got code';
        is $result -> name, 'name', 'got name';
        is $result -> is_published, 1, 'got is_published';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub second_insert {
    my $self = shift;

    try {
        my $fareclass = ClubSpain::Model::FareClass->new(
            code    => 'J',
            name    => 'yyyy',
            is_published => 1,
        );
        my $result = $fareclass->create();

        pass('no exception thrown');
        isa_ok($result, 'ClubSpain::Schema::Result::FareClass');
        is $result -> code, 'J', 'got code';
        is $result -> name, 'yyyy', 'got name';
        is $result -> is_published, 1, 'got is_published';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub test_06_update :Test(5) {
    my $self = shift;

    my $fareclass = ClubSpain::Model::FareClass->new(
        id          => 1,
        code        => 'R',
        name        => 'New FareClass name',
        is_published=> 0,
    );

    my $result = $fareclass->update();

    isa_ok($result, 'ClubSpain::Schema::Result::FareClass');
    is $result -> id, 1, 'got id';
    is $result -> code, 'R', 'got code';
    is $result -> name, 'New FareClass name', 'got name';
    is $result -> is_published, 0, 'got is_published';

    return;
}

sub test_07_update_call_as_class_method :Test() {
    my $self = shift;

    try {
        ClubSpain::Model::FareClass -> update();
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
        my $fareclass = ClubSpain::Model::FareClass->new(
            id          => 1000,
            code        => 'R',
            name        => 'New FareClass name',
            is_published=> 0,
        );

        $fareclass -> update();
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
        ClubSpain::Model::FareClass -> delete(1000);
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
        my $fareclass = ClubSpain::Model::FareClass->new(
            id          => 1000,
            code        => 'R',
            name        => 'New FareClass name',
            is_published=> 0,
        );

        $fareclass -> delete();
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
    my $count = $schema -> resultset( 'FareClass' ) -> search({}) -> count();

    my $fareclass = ClubSpain::Model::FareClass -> new(
        code    => 'z',
        name    => 'zzzzz',
        is_published => 0,
    );

    my $object = $fareclass -> create();

    isa_ok($object, 'ClubSpain::Schema::Result::FareClass');
    is $object -> code, 'z', 'got code';
    is $object -> name, 'zzzzz', 'got name';
    is $object -> is_published, 0, 'got is published';


    ClubSpain::Model::FareClass -> delete( $object -> id() );

    my $rs = $schema -> resultset( 'FareClass' ) -> search({});
    is( $rs -> count(), $count, 'no objects left' );

    return;
}

1;