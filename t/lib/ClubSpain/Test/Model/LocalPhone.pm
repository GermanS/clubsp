package ClubSpain::Test::Model::LocalPhone;

use strict;
use warnings;

use ClubSpain::Model::LocalPhone;

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

sub test_00_simple :Test( 4 ) {
    my $self = shift;

    my %params = (
        office_id    => 1,
        number       => 4957831234,
        is_published => 1
    );

    my $phone = ClubSpain::Model::LocalPhone -> new( %params );

    isa_ok( $phone, 'ClubSpain::Model::LocalPhone' );

    is $phone -> get_office_id,    $params{ 'office_id' },    'got office id';
    is $phone -> get_number,       $params{ 'number' },       'got phone number';
    is $phone -> get_is_published, $params{ 'is_published' }, 'got is published flag';

    return;
}

sub test_03_fetch_with_exception :Test {
    my $self = shift;

    try {
        ClubSpain::Model::LocalPhone -> fetch_by_id(1000);
        fail( 'no exception thrown' );

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
        my $phone = ClubSpain::Model::LocalPhone -> new(
            id           => 1000,
            office_id    => 1,
            number       => 4957831234,
            is_published => 1
        );
        $phone -> fetch_by_id();

        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'caught ClubSpain::Exception::Storage');
        is $e -> message, 'Couldn\'t find LocalPhone: 1000!', 'got message';

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

    my %params = (
        office_id    => 1,
        number       => 1234567890,
        is_published => 1,
    );

    try {
        my $phone = ClubSpain::Model::LocalPhone -> new( %params );
        my $result = $phone -> create();

        pass( 'no exception thrown' );

        isa_ok $result, 'ClubSpain::Schema::Result::LocalPhone';

        is $result -> office_id(),    $params{ 'office_id' },    'got office id';
        is $result -> number(),       $params{ 'number' },       'got phone number';
        is $result -> is_published(), $params{ 'is_published' }, 'got is_published';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub second_insert {
    my $self = shift;

    my %params = (
        office_id    => 1,
        number       => 8765432190,
        is_published => 1
    );

    try {
        my $phone = ClubSpain::Model::LocalPhone -> new( %params );
        my $result = $phone -> create();

        pass( 'no exception thrown' );

        isa_ok $result, 'ClubSpain::Schema::Result::LocalPhone';
        is $result -> office_id(),    $params{ 'office_id' },    'got office id';
        is $result -> number(),       $params{ 'number' },       'got phone number';
        is $result -> is_published(), $params{ 'is_published' }, 'got is_published';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub test_06_update :Test(6) {
    my $self = shift;

    my $phone = ClubSpain::Model::LocalPhone -> new(
        office_id    => 1,
        number       => 4455566777,
        is_published => 0,
    );
    my $init = $phone -> create();

    my %params = (
        id           => $init -> id(),
        office_id    => 1,
        number       => 8888999900,
        is_published => 1,
    );

    try {
        my $phone = ClubSpain::Model::LocalPhone -> new( %params );
        my $result = $phone -> update();

        isa_ok $result, 'ClubSpain::Schema::Result::LocalPhone';
        is $result -> office_id(),    $params{ 'office_id' },    'got office id';
        is $result -> number(),       $params{ 'number' },       'got phone number';
        is $result -> is_published(), $params{ 'is_published' }, 'got is published flag';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    }

    return;
}

sub test_07_update_call_as_class_method :Test() {
    my $self = shift;

    try {
        ClubSpain::Model::LocalPhone -> update();
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
        my $phone = ClubSpain::Model::LocalPhone -> new(
            id           => 1000,
            office_id    => 1,
            number       => 8888999900,
            is_published => 1,
        );
        $phone -> update();

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
        ClubSpain::Model::LocalPhone -> delete(1000);
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
        my $phone = ClubSpain::Model::LocalPhone -> new(
            id           => 23,
            office_id    => 1,
            number       => 8888999900,
            is_published => 1,
        );
        $phone -> delete();

        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass('Object Method: caught Storage exception');

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    };

    return;
}

sub test_11_delete :Test(6) {
    my $self = shift;

    my $schema = $self -> { 'schema' } -> schema();
    my $count = $schema -> resultset( 'LocalPhone' ) -> search({}) -> count();

    my %params = (
        office_id    => 1,
        number       => 7778889991,
        is_published => 0,
    );

    my $phone  = ClubSpain::Model::LocalPhone -> new( %params );
    my $object = $phone -> create();

    isa_ok $object, 'ClubSpain::Schema::Result::LocalPhone';
    is $object -> office_id(),    $params{'office_id'},      'got office id';
    is $object -> number(),       $params{'number'},         'got phone number';
    is $object -> is_published(), $params{ 'is_published' }, 'got is published';

    ClubSpain::Model::LocalPhone -> delete( $object -> id() );

    my $rs = $schema -> resultset( 'LocalPhone' ) -> search({});
    is $rs -> count(), $count, 'no objects left';

    return;
}

1;