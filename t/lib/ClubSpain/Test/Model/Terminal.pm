package ClubSpain::Test::Model::Terminal;

use strict;
use warnings;

use ClubSpain::Model::Terminal;

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

    my $terminal = ClubSpain::Model::Terminal -> new(
        airport_id   => 1,
        name         => 'Sector A',
        is_published => 1,
    );

    isa_ok($terminal, 'ClubSpain::Model::Terminal');
    is $terminal -> get_airport_id, 1, 'got airport id';
    is $terminal -> get_name, 'Sector A', 'got name';
    is $terminal -> get_is_published, 1, 'got is published';

    return;
}

sub test_01_fetch :Test(4) {
    my $self = shift;

    my $terminal = ClubSpain::Model::Terminal->fetch_by_id(1);

    isa_ok($terminal, 'ClubSpain::Schema::Result::Terminal');
    is $terminal -> airport_id, 3, 'got airport';
    is $terminal -> name, 'Terminal B', 'got name';
    is $terminal -> is_published, 1, 'got is published';

    return;
}

sub test_02_fetch :Test(4) {
    my $self = shift;

    my $terminal = ClubSpain::Model::Terminal -> new(
        id           => 1,
        airport_id   => 0,
        name         => 'name',
        is_published => 0,
    );

    my $object = $terminal -> fetch_by_id();

    isa_ok($object, 'ClubSpain::Schema::Result::Terminal');
    is $object -> airport_id, 3, 'got airport';
    is $object -> name, 'Terminal B', 'got name';
    is $object -> is_published, 1, 'got is published';

    return;
}

sub test_03_fetch_with_exception :Test {
    my $self = shift;

    try {
        ClubSpain::Model::Terminal -> fetch_by_id(1000);
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
        my $terminal = ClubSpain::Model::Terminal -> new(
            id           => 1000,
            airport_id   => 0,
            name         => 'name',
            is_published => 1,
        );
        $terminal -> fetch_by_id();

        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'caught ClubSpain::Exception::Storage');
        is $e -> message, 'Couldn\'t find Terminal: 1000!', 'got message';

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
        my $terminal = ClubSpain::Model::Terminal -> new(
            airport_id   => 1,
            name         => 'xxxxx',
            is_published => 1,
        );
        my $result = $terminal -> create();

        pass( 'no exception thrown' );

        isa_ok $result, 'ClubSpain::Schema::Result::Terminal';
        is $result -> airport_id, 1, 'got airport';
        is $result -> name, 'xxxxx', 'got name';
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
        my $terminal = ClubSpain::Model::Terminal -> new(
            airport_id   => 2,
            name         => 'yyyyy',
            is_published => 1,
        );
        my $result = $terminal -> create();

        pass('no exception thrown');

        isa_ok $result, 'ClubSpain::Schema::Result::Terminal';
        is $result -> airport_id, 2, 'got airport';
        is $result -> name, 'yyyyy', 'got name';
        is $result -> is_published, 1, 'got is_published';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub test_06_update :Test(5) {
    my $self = shift;

    try {
        my $terminal = ClubSpain::Model::Terminal->new(
            id           => 1,
            airport_id   => 1,
            name         => 'New Terminal name',
            is_published => 0,
        );

        my $result = $terminal -> update();

        isa_ok($result, 'ClubSpain::Schema::Result::Terminal');
        is $result -> id, 1, 'got id';
        is $result -> airport_id, 1, 'got icao code';
        is $result -> name, 'New Terminal name', 'got name';
        is $result -> is_published, 0, 'got is_published';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    }

    return;
}

sub test_07_update_call_as_class_method :Test() {
    my $self = shift;

    try {
        ClubSpain::Model::Terminal -> update();
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
        my $terminal = ClubSpain::Model::Terminal->new(
            id           => 1000,
            airport_id   => 1,
            name         => 'name',
            is_published => 0,
        );
        $terminal -> update();

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
        ClubSpain::Model::Terminal -> delete(1000);
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
        my $terminal = ClubSpain::Model::Terminal->new(
            id           => 1000,
            airport_id   => 1,
            name         => 'name',
            is_published => 0,
        );

        $terminal -> delete();

        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass('Object Method: caught Storage exception');

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    };

    return;
}

sub test_11_delete :Test(5) {
    my $self = shift;

    my $schema = $self -> { 'schema' } -> schema();
    my $count  = $schema -> resultset( 'Terminal' ) -> search({}) -> count();

    my $terminal = ClubSpain::Model::Terminal -> new(
        airport_id   => 1,
        name         => 'xxxxx',
        is_published => 0,
    );

    my $object = $terminal->create();

    isa_ok($object, 'ClubSpain::Schema::Result::Terminal');
    is $object -> airport_id, 1, 'got airport';
    is $object -> name, 'xxxxx', 'got name';
    is $object -> is_published, 0, 'got is published';

    ClubSpain::Model::Terminal -> delete( $object -> id() );

    my $rs = $schema -> resultset( 'Terminal' ) -> search({});
    is $rs -> count(), $count, 'no objects left';

    return;
}

1;