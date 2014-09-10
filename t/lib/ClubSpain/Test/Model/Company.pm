package ClubSpain::Test::Model::Company;

use strict;
use warnings;

use ClubSpain::Model::Company;

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

sub test_00_simple :Test( 11 ) {
    my $self = shift;

    my $company = ClubSpain::Model::Company->new(
        zipcode      => 123456,
        street       => 'calle de colomn 4',
        name         => 'origin name',
        nick         => 'brand name',
        website      => 'somewhere.com',
        INN          => 7702581366,
        OKPO         => 79011171,
        OKVED        => 4234567890,
        is_NDS       => 1,
        is_published => 1,
    );

    isa_ok($company, 'ClubSpain::Model::Company');
    is $company -> get_zipcode, 123456, 'got zipcode';
    is $company -> get_street, 'calle de colomn 4', 'got street name';
    is $company -> get_name, 'origin name', 'got name';
    is $company -> get_nick, 'brand name', 'got nickname';
    is $company -> get_website, 'somewhere.com', 'got website';
    is $company -> get_INN, 7702581366, 'got INN';
    is $company -> get_OKPO, 79011171, 'got OKPO';
    is $company -> get_OKVED, 4234567890, 'got OKVED';
    is $company -> get_is_NDS, 1, 'got is_NDS';
    is $company -> get_is_published, 1, 'got is_published';

    return;
}

sub test_03_fetch_with_exception :Test {
    my $self = shift;

    try {
        ClubSpain::Model::Company -> fetch_by_id(1000);
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
        my $company = ClubSpain::Model::Company -> new(
            id           => 1000,
            zipcode      => 123456,
            street       => 'calle de colomn 4',
            name         => 'origin name',
            nick         => 'brand name',
            website      => 'somewhere.com',
            INN          => 7702581366,
            OKPO         => 79011171,
            OKVED        => 4234567890,
            is_NDS       => 1,
            is_published => 1,
        );
        $company -> fetch_by_id();

        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'caught ClubSpain::Exception::Storage');
        is $e -> message, 'Couldn\'t find Company: 1000!', 'got message';

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    }

    return;
}

sub test_05_create :Test( 22 ) {
    my $self = shift;

    $self -> first_insert();
    $self -> second_insert();

    return;
}

sub first_insert {
    my $self = shift;

    try {
        my $company = ClubSpain::Model::Company -> new(
            zipcode      => 123456,
            street       => 'calle de colomn 4',
            name         => 'origin name',
            nick         => 'brand name',
            website      => 'somewhere.com',
            INN          => 7702581366,
            OKPO         => 79011171,
            OKVED        => 4234567890,
            is_NDS       => 1,
            is_published => 1
        );

        my $result = $company -> create();

        pass('no exception thrown');

        is $result -> zipcode, 123456, 'got zipcode';
        is $result -> street, 'calle de colomn 4', 'got street';
        is $result -> name, 'origin name', 'origin name';
        is $result -> nick, 'brand name', 'brand name';
        is $result -> website, 'somewhere.com', 'got website';
        is $result -> INN, 7702581366, 'got INN';
        is $result -> OKPO, 79011171, 'got OKPO';
        is $result -> OKVED, 4234567890, 'got OKVED';
        is $result -> is_NDS, 1, 'got is_NDS';
        is $result -> is_published, 1, 'got is_published';

        return $result;

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub second_insert {
    my $self = shift;

    try {
        my $company = ClubSpain::Model::Company->new(
            zipcode      => 654321,
            street       => 'calle de colomn 6',
            name         => 'new name',
            nick         => 'new nick',
            website      => 'somewhere.net',
            INN          => 673002363905,
            OKPO         => 7901117001,
            OKVED        => 1234,
            is_NDS       => 0,
            is_published => 0,
        );
        my $result = $company -> create();

        pass('no exception thrown');

        is $result -> zipcode, 654321, 'got zipcode';
        is $result -> street, 'calle de colomn 6', 'got street';
        is $result -> name, 'new name', 'origin name';
        is $result -> nick, 'new nick', 'brand name';
        is $result -> website, 'somewhere.net', 'got website';
        is $result -> INN, 673002363905, 'got INN';
        is $result -> OKPO, 7901117001, 'got OKPO';
        is $result -> OKVED, 1234, 'got OKVED';
        is $result -> is_NDS, 0, 'got is_NDS';
        is $result -> is_published, 0, 'got is_published';

        $self -> { 'company_for_update' } = $result;

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    }

    return;
}

sub test_06_update :Test(11) {
    my $self = shift;

    try {
        my $company = ClubSpain::Model::Company->new(
            id           => $self -> { 'company_for_update' } -> id(),
            zipcode      => 123000,
            street       => 'calle de colomn 4 upd',
            name         => 'origin name upd',
            nick         => 'brand name upd',
            website      => 'somewhere.com',
            INN          => 673002363905,
            OKPO         => 7901117001,
            OKVED        => 4234567000,
            is_NDS       => 1,
            is_published => 1
        );

        my $result = $company -> update();

        isa_ok($result, 'ClubSpain::Schema::Result::Company');
        is $result -> zipcode, 123000, 'got zipcode';
        is $result -> street, 'calle de colomn 4 upd', 'got street';
        is $result -> name, 'origin name upd', 'origin name';
        is $result -> nick, 'brand name upd', 'brand name';
        is $result -> website, 'somewhere.com', 'got website';
        is $result -> INN, 673002363905, 'got INN';
        is $result -> OKPO, 7901117001, 'got OKPO';
        is $result -> OKVED, 4234567000, 'got OKVED';
        is $result -> is_NDS, 1, 'got is_NDS';
        is $result -> is_published, 1, 'got is_published';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub test_07_update_call_as_class_method :Test() {
    my $self = shift;

    try {
        ClubSpain::Model::Company -> update();
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
        my $company = ClubSpain::Model::Company -> new(
            id           => 1000,
            zipcode      => 123000,
            street       => 'calle de colomn 4 upd',
            name         => 'origin name upd',
            nick         => 'brand name upd',
            website      => 'somewhere.com',
            INN          => 673002363905,
            OKPO         => 7901117001,
            OKVED        => 4234567000,
            is_NDS       => 1,
            is_published => 1
        );
        $company -> update();

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
        ClubSpain::Model::Company -> delete(1000);
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
        my $company = ClubSpain::Model::Company -> new(
            id           => 1000,
            zipcode      => 123000,
            street       => 'calle de colomn 4 upd',
            name         => 'origin name upd',
            nick         => 'brand name upd',
            website      => 'somewhere.com',
            INN          => 673002363905,
            OKPO         => 7901117001,
            OKVED        => 4234567000,
            is_NDS       => 1,
            is_published => 1
        );
        $company -> delete();

        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass('Object Method: caught Storage exception');

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    };

    return;
}

sub test_11_delete :Test(12) {
    my $self = shift;

    my $schema = $self -> { 'schema' } -> schema();
    my $count = $schema -> resultset( 'Company' ) -> search({}) -> count();

    my $company = ClubSpain::Model::Company->new(
        zipcode      => 129345,
        street       => 'ivana babushkina 16',
        name         => 'aviabroker.com',
        nick         => 'aviabroker.com',
        website      => 'somewhere.com',
        INN          => 7701833652,
        OKPO         => 79011171,
        OKVED        => 4234567890,
        is_NDS       => 1,
        is_published => 1,
    );

    my $object = $company -> create();

    isa_ok($object, 'ClubSpain::Schema::Result::Company');
    is $object -> zipcode, 129345, 'got zipcode';
    is $object -> street, 'ivana babushkina 16', 'got street';
    is $object -> name, 'aviabroker.com', 'got name';
    is $object -> nick, 'aviabroker.com', 'got nick';
    is $object -> website, 'somewhere.com', 'got website';
    is $object -> INN, 7701833652, 'got inn';
    is $object -> OKPO, 79011171, 'got okpo';
    is $object -> OKVED, 4234567890, 'got okved';
    is $object -> is_NDS, 1, 'got is_NDS';
    is $object -> is_published, 1, 'got is_piblished';

    ClubSpain::Model::Company -> delete( $object -> id() );

    my $rs = $schema -> resultset( 'Company' ) -> search({});
    is $rs -> count(), $count, 'no objects left';

    return;
}

1;