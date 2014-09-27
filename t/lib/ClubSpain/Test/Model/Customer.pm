package ClubSpain::Test::Model::Customer;

use strict;
use warnings;

use ClubSpain::Model::Customer;

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

sub test_00_simple :Test( 7 ) {
    my $self = shift;

    my $params = {
        name         => 'Иван',
        surname      => 'Иванов',
        email        => 'ivan@ivanov.ru',
        passwd       => 'passwd',
        mobile       => 9851234567,
        is_published => 1,
    };

    my $customer = ClubSpain::Model::Customer -> new( $params );

    isa_ok($customer, 'ClubSpain::Model::Customer');
    is $customer -> get_name(),         $params -> { 'name' }, 'got name';
    is $customer -> get_surname(),      $params -> { 'surname' }, 'got surname';
    is $customer -> get_email(),        $params -> { 'email' }, 'got email';
    is $customer -> get_passwd(),       $params -> { 'passwd' }, 'got passwd';
    is $customer -> get_mobile(),       $params -> { 'mobile' }, 'got mobile';
    is $customer -> get_is_published(), $params -> { 'is_published' }, 'got is published';

    return;
}

sub test_03_fetch_with_exception :Test {
    my $self = shift;

    try {
        ClubSpain::Model::Customer -> fetch_by_id(1000);
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
        my $airline = ClubSpain::Model::Customer -> new(
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
        is $e -> message(), 'Couldn\'t find Customer: 1000!', 'got message';

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
        name         => 'Иван',
        surname      => 'Иванов',
        email        => 'ivan@ivanov.com',
        passwd       => 'passwd',
        mobile       => 9101234567,
        is_published => 1,
    );

    try {
        my $customer = ClubSpain::Model::Customer -> new( %params );

        my $result = $customer -> create();

        isa_ok($result, 'ClubSpain::Schema::Result::Customer');
        is $result -> name(),         $params{ 'name' },    'got name';
        is $result -> surname(),      $params{ 'surname' }, 'got surname';
        is $result -> email(),        $params{ 'email' },   'got email';
        is $result -> passwd(),       $params{ 'passwd' },  'got passwd';
        is $result -> mobile(),       $params{ 'mobile' },  'got mobile';
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
        name        => 'Jose',
        surname     => 'Cuesta',
        email       => 'jose@yahoo.com',
        passwd      => 'passwd',
        mobile      => '9054582124',
        is_published => 1,
    );

    try {
        my $customer = ClubSpain::Model::Customer -> new( %params );

        my $result = $customer -> create();

        isa_ok($result, 'ClubSpain::Schema::Result::Customer');
        is $result -> name(),         $params{ 'name' },    'got name';
        is $result -> surname(),      $params{ 'surname' }, 'got surname';
        is $result -> email(),        $params{ 'email' },   'got email';
        is $result -> passwd(),       $params{ 'passwd' },  'got passwd';
        is $result -> mobile(),       $params{ 'mobile' },  'got mobile';
        is $result -> is_published(), $params{ 'is_published' }, 'got is published';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub test_06_update :Test( 6 ) {
    my $self = shift;

    my $customer1 = ClubSpain::Model::Customer -> new(
        name        => 'Jose',
        surname     => 'Cuesta',
        email       => 'info@mail.com',
        passwd      => 'passwd',
        mobile      => '9054583224',
        is_published => 1,
    );
    my $result1 = $customer1 -> create();


    my %params = (
        id          => $result1 -> id(),
        name        => 'Raul',
        surname     => 'Perez',
        email       => 'raul@gmail.com',
        passwd      => 'passwd1',
        mobile      => '9254585224',
        is_published => 0,
    );
    my $customer2 = ClubSpain::Model::Customer -> new( %params );

    my $result = $customer2 -> update();

    is $result -> name(),         $params{ 'name' },    'got name';
    is $result -> surname(),      $params{ 'surname' }, 'got surname';
    is $result -> email(),        $params{ 'email' },   'got email';
    is $result -> passwd(),       $params{ 'passwd' },  'got passwd';
    is $result -> mobile(),       $params{ 'mobile' },  'got mobile';
    is $result -> is_published(), $params{ 'is_published' }, 'got is published';

    return;
}

sub test_07_update_call_as_class_method :Test() {
    my $self = shift;

    try {
        ClubSpain::Model::Customer -> update();
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
        my $customer = ClubSpain::Model::Customer -> new(
            id           => 777,
            name        => 'Jose',
            surname     => 'Cuesta',
            email       => 'info@mail.com',
            passwd      => 'passwd',
            mobile      => '9105458224',
            is_published => 1,
        );
        $customer -> update();

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
        ClubSpain::Model::Customer -> delete(1000);
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
        my $customer = ClubSpain::Model::Customer -> new(
            id          => 23,
            name        => 'Jose',
            surname     => 'Cuesta',
            email       => 'info@mail.com',
            passwd      => 'passwd',
            mobile      => '9054582224',
            is_published => 1,
        );
        $customer -> delete();

        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass('Object Method: caught Storage exception');

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    };

    return;
}

sub test_11_delete :Test( 8 ) {
    my $self = shift;

    my $schema = $self -> { 'schema' } -> schema();
    my $count = $schema -> resultset( 'Customer' ) -> search({}) -> count();

    my %params = (
        name        => 'Jose',
        surname     => 'Cuesta',
        email       => 'info@mail.com',
        passwd      => 'passwd',
        mobile      => '9054582224',
        is_published => 1,
    );

    my $customer = ClubSpain::Model::Customer -> new( %params );
    my $object   = $customer -> create();

    isa_ok($object, 'ClubSpain::Schema::Result::Customer');
    is $object -> name(),         $params{ 'name' },    'got name';
    is $object -> surname(),      $params{ 'surname' }, 'got surname';
    is $object -> email(),        $params{ 'email' },   'got email';
    is $object -> passwd(),       $params{ 'passwd' },  'got passwd';
    is $object -> mobile(),       $params{ 'mobile' },  'got mobile';
    is $object -> is_published(), $params{ 'is_published' }, 'got is_published';


    ClubSpain::Model::Customer -> delete( $object -> id() );

    my $rs = $schema -> resultset( 'Customer' ) -> search({});
    is $rs -> count(), $count, 'no objects left';

    return;
}

1;

__END__