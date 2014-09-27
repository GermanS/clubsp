package ClubSpain::Test::Model::Operator;

use strict;
use warnings;

use ClubSpain::Model::Operator;

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
        office_id    => 1,
        name         => 'Иван',
        surname      => 'Иванов',
        email        => 'ivan@ivanov.ru',
        passwd       => 'passwd',
        mobile       => 9851234567,
        is_published => 1,
    );

    my $operator = ClubSpain::Model::Operator -> new( %params );

    isa_ok( $operator, 'ClubSpain::Model::Operator' );

    is $operator -> get_office_id(),    $params{ 'office_id' },    'got office id';
    is $operator -> get_name(),         $params{ 'name' },         'got name';
    is $operator -> get_surname(),      $params{ 'surname' },      'got surname';
    is $operator -> get_email(),        $params{ 'email' },        'got email';
    is $operator -> get_passwd(),       $params{ 'passwd' },       'got passwd';
    is $operator -> get_mobile(),       $params{ 'mobile' },       'got mobile';
    is $operator -> get_is_published(), $params{ 'is_published' }, 'got is published';

    return;
}

sub test_03_fetch_with_exception :Test {
    my $self = shift;

    try {
        ClubSpain::Model::Operator -> fetch_by_id(1000);
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
        my $operator = ClubSpain::Model::Operator -> new(
            id           => 1000,
            iata         => 'xx',
            icao         => 'xxx',
            name         => 'name',
            is_published => 1,
        );
        $operator -> fetch_by_id();

        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'caught ClubSpain::Exception::Storage');
        is $e -> message, 'Couldn\'t find Operator: 1000!', 'got message';

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    }

    return;
}

sub test_05_create :Test( 18 ) {
    my $self = shift;

    $self -> first_insert();
    $self -> second_insert();

    return;
}

sub first_insert {
    my $self = shift;

    my %params = (
        office_id    => 1,
        name         => 'Иван',
        surname      => 'Иванов',
        email        => 'ivan@ivanov.com',
        passwd       => 'passwd',
        mobile       => 9101234567,
        is_published => 1,
    );

    try {
        my $operator = ClubSpain::Model::Operator -> new( %params );
        my $result   = $operator -> create();

        pass('no exception thrown');

        isa_ok($result, 'ClubSpain::Schema::Result::Operator');
        is $result -> office_id(),    $params{ 'office_id' },    'got office id';
        is $result -> name(),         $params{ 'name' },         'got name';
        is $result -> surname(),      $params{ 'surname' },      'got surname';
        is $result -> email(),        $params{ 'email' },        'got email';
        is $result -> passwd(),       $params{ 'passwd' },       'got passwd';
        is $result -> mobile(),       $params{ 'mobile' },       'got mobile';
        is $result -> is_published(), $params{ 'is_published' }, 'got is published';

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
        name         => 'Jose',
        surname      => 'Cuesta',
        email        => 'jose@yahoo.com',
        passwd       => 'passwd',
        mobile       => '9054582124',
        is_published => 1,
    );

    try {
        my $operator = ClubSpain::Model::Operator -> new( %params );
        my $result   = $operator -> create();

        pass('no exception thrown');

        isa_ok($result, 'ClubSpain::Schema::Result::Operator');
        is $result -> office_id(),    $params{ 'office_id' },    'got office id';
        is $result -> name(),         $params{ 'name' },         'got name';
        is $result -> surname(),      $params{ 'surname' },      'got surname';
        is $result -> email(),        $params{ 'email' },        'got email';
        is $result -> passwd(),       $params{ 'passwd' },       'got passwd';
        is $result -> mobile(),       $params{ 'mobile' },       'got mobile';
        is $result -> is_published(), $params{ 'is_published' }, 'got is published';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub test_06_update :Test( 7 ) {
    my $self = shift;

    try {
        my $operator1 = ClubSpain::Model::Operator -> new(
            office_id   => 1,
            name        => 'Jose',
            surname     => 'Cuesta',
            email       => 'info@mail.com',
            passwd      => 'passwd',
            mobile      => '9054583224',
            is_published => 1,
        );
        my $result1 = $operator1 -> create();

        my %params = (
            id          => $result1 -> id(),
            office_id   => $result1 -> office_id(),
            name        => 'Raul',
            surname     => 'Perez',
            email       => 'raul@gmail.com',
            passwd      => 'passwd1',
            mobile      => '9254585224',
            is_published => 0,
        );

        my $operator2 = ClubSpain::Model::Operator -> new( %params );

        my $object = $operator2 -> update();

        is $object -> office_id(),    $params{ 'office_id' },    'got office id';
        is $object -> name(),         $params{ 'name' },         'got name';
        is $object -> surname(),      $params{ 'surname' },      'got surname';
        is $object -> email(),        $params{ 'email' },        'got email';
        is $object -> passwd(),       $params{ 'passwd' },       'got passwd';
        is $object -> mobile(),       $params{ 'mobile' },       'got mobile';
        is $object -> is_published(), $params{ 'is_published' }, 'got is_published';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    }

    return;
}

sub test_07_update_call_as_class_method :Test() {
    my $self = shift;

    try {
        ClubSpain::Model::Operator -> update();
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
        my $operator = ClubSpain::Model::Operator -> new(
            id           => 1000,
            office_id    => 1,
            name         => 'Raul',
            surname      => 'Perez',
            email        => 'raul@gmail.com',
            passwd       => 'passwd1',
            mobile       => '9254585224',
            is_published => 0,
        );
        $operator -> update();

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
        ClubSpain::Model::Operator -> delete(1000);
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
        my $operator = ClubSpain::Model::Operator -> new(
            id           => 1000,
            office_id    => 1,
            name         => 'Raul',
            surname      => 'Perez',
            email        => 'raul@gmail.com',
            passwd       => 'passwd1',
            mobile       => '9254585224',
            is_published => 0,
        );
        $operator -> delete();

        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass('Object Method: caught Storage exception');

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    };

    return;
}

sub test_11_delete :Test( 9 ) {
    my $self = shift;

    my $schema = $self -> { 'schema' } -> schema();
    my $count = $schema -> resultset( 'Operator' ) -> search({}) -> count();

    my %params = (
        office_id   => 1,
        name        => 'Jose',
        surname     => 'Cuesta',
        email       => 'info@mail.com',
        passwd      => 'passwd',
        mobile      => '9054582224',
        is_published => 1,
    );

    my $operator = ClubSpain::Model::Operator -> new( %params );

    my $object = $operator -> create();

    isa_ok($object, 'ClubSpain::Schema::Result::Operator');
    is $object -> office_id(),    $params{ 'office_id' }, 'got office id';
    is $object -> name(),         $params{ 'name' },      'got name';
    is $object -> surname(),      $params{ 'surname' },   'got surname';
    is $object -> email(),        $params{ 'email' },     'got email';
    is $object -> passwd(),       $params{ 'passwd' },    'got passwd';
    is $object -> mobile(),       $params{ 'mobile' },    'got mobile';
    is $object -> is_published(), $params{ 'is_published' }, 'got is_published';

    ClubSpain::Model::Operator -> delete( $object -> id() );

    my $rs = $schema -> resultset( 'Operator' ) -> search({});
    is $rs -> count(), $count, 'no objects left';

    return;
}

1;

__END__