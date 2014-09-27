package ClubSpain::Test::Model::Employee;

use strict;
use warnings;

use ClubSpain::Model::Employee;

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

sub test_00_simple :Test( 6 ) {
    my $self = shift;

    my %params = (
        name         => 'Petr',
        surname      => 'Petrov',
        email        => 'info@aviabroker.com',
        password     => 'passwd',
        is_published => 1,
    );

    my $employee = ClubSpain::Model::Employee -> new( %params );

    isa_ok $employee, 'ClubSpain::Model::Employee';

    is $employee -> get_name(),         $params{ 'name' },         'got name';
    is $employee -> get_surname(),      $params{ 'surname' },      'got surname';
    is $employee -> get_email(),        $params{ 'email' },        'got email';
    is $employee -> get_password(),     $params{ 'password' },     'got passwd';
    is $employee -> get_is_published(), $params{ 'is_published' }, 'got is published';

    return;
}

sub test_03_fetch_with_exception :Test {
    my $self = shift;

    try {
        ClubSpain::Model::Employee -> fetch_by_id(1000);
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
        my $employee = ClubSpain::Model::Employee -> new(
            id           => 1000,
            name         => 'Petr',
            surname      => 'Petrov',
            email        => 'info@aviabroker.com',
            password     => 'passwd',
            is_published => 1,
        );
        $employee -> fetch_by_id();

        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'caught ClubSpain::Exception::Storage');
        is $e -> message, 'Couldn\'t find Employee: 1000!', 'got message';

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    }

    return;
}

sub test_05_create :Test( 14 ) {
    my $self = shift;

    $self -> first_insert();
    $self -> second_insert();

    return;
}

sub first_insert {
    my $self = shift;

    my %params = (
        name         => 'Petr',
        surname      => 'Petrov',
        email        => 'info@aviabroker.com',
        password     => 'passwd',
        is_published => 1,
    );

    try {
        my $employee = ClubSpain::Model::Employee -> new( %params );
        my $result = $employee -> create();

        pass('no exception thrown');

        isa_ok($result, 'ClubSpain::Schema::Result::Employee');
        is $result -> name(),         $params{ 'name' },         'got name';
        is $result -> surname(),      $params{ 'surname' },      'got surname';
        is $result -> email(),        $params{ 'email' },        'got email';
        is $result -> password(),     $params{ 'password' },     'got passwd';
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
        name         => 'Ivan',
        surname      => 'Ivanov',
        email        => 'alc@aviabroker.com',
        password     => 'passwd',
        is_published => 1,
    );

    try {
        my $employee = ClubSpain::Model::Employee -> new( %params );
        my $result = $employee -> create();

        pass('no exception thrown');

        isa_ok($result, 'ClubSpain::Schema::Result::Employee');
        is $result -> name(),         $params{ 'name' },         'got name';
        is $result -> surname(),      $params{ 'surname' },      'got surname';
        is $result -> email(),        $params{ 'email' },        'got email';
        is $result -> password(),     $params{ 'password' },     'got passwd';
        is $result -> is_published(), $params{ 'is_published' }, 'got is published';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub test_06_update :Test( 7 ) {
    my $self = shift;

    my %params = (
        id           => 1,
        name         => 'german',
        surname      => 'semenkov',
        email        => 'german.semenkov@gmail.com',
        password     => '123',
        is_published => 0,
    );

    try {
        my $employee = ClubSpain::Model::Employee -> new( %params );

        my $result = $employee -> update();

        isa_ok($result, 'ClubSpain::Schema::Result::Employee');
        is $result -> id(),           $params{ 'id' },       'got id';
        is $result -> name(),         $params{ 'name' },     'got name';
        is $result -> surname(),      $params{ 'surname' },  'got surname';
        is $result -> email(),        $params{ 'email' },    'got email';
        is $result -> password(),     $params{ 'password' }, 'got pass';
        is $result -> is_published(), $params{ 'is_published' },  'got is_published';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    }

    return;
}

sub test_07_update_call_as_class_method :Test() {
    my $self = shift;

    try {
        ClubSpain::Model::Employee -> update();
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
        my $employee = ClubSpain::Model::Employee -> new(
            id           => 1000,
            name         => 'Ivan',
            surname      => 'Ivanov',
            email        => 'alc@aviabroker.com',
            password     => 'passwd',
            is_published => 1,
        );
        $employee -> update();

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
        ClubSpain::Model::Employee -> delete(1000);
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
        my $employee = ClubSpain::Model::Employee -> new(
            id           => 23,
            name         => 'Ivan',
            surname      => 'Ivanov',
            email        => 'alc@aviabroker.com',
            password     => 'passwd',
            is_published => 1,
        );
        $employee -> delete();

        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass('Object Method: caught Storage exception');

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    };

    return;
}

sub test_11_delete :Test( 7 ) {
    my $self = shift;

    my $schema = $self -> { 'schema' } -> schema();
    my $count = $schema -> resultset( 'Employee' ) -> search({}) -> count();

    my %params = (
        name         => 'Petr',
        surname      => 'Petrov',
        email        => 'test@aviabroker.com',
        password     => 'passwd',
        is_published => 1,
    );

    my $employee = ClubSpain::Model::Employee -> new( %params );

    my $object = $employee -> create();

    isa_ok($object, 'ClubSpain::Schema::Result::Employee');
    is $object -> name(),         $params{ 'name' },         'got name';
    is $object -> surname(),      $params{ 'surname' },      'got surname';
    is $object -> email(),        $params{ 'email' },        'got email';
    is $object -> password(),     $params{ 'password' },     'got password';
    is $object -> is_published(), $params{ 'is_published' }, 'got is_published';

    ClubSpain::Model::Employee -> delete( $object->id()  );

    my $rs = $schema -> resultset( 'Employee' ) -> search({});
    is $rs -> count(), $count, 'no objects left';

    return;
}

1;

__END__