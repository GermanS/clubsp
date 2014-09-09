package ClubSpain::Test::Model::City;

use strict;
use warnings;
use utf8;

use ClubSpain::Model::City;

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

    my $city = ClubSpain::Model::City -> new(
        country_id      => 1,
        iata            => 'VOG',
        name_en         => 'Volgograd',
        name_ru         => 'Волгоград',
        is_published    => 1,
    );

    isa_ok($city, 'ClubSpain::Model::City');
    is $city -> get_country_id, 1, 'got country_id';
    is $city -> get_iata, 'VOG', 'got iata code';
    is $city -> get_name_en, 'Volgograd', 'got name';
    is $city -> get_name_ru, 'Волгоград', 'got ru name';
    is $city -> get_is_published, 1, 'got header';

    return;
}

sub test_01_fetch :Test(6) {
    my $self = shift;

    my $city = ClubSpain::Model::City -> fetch_by_id(1);

    isa_ok($city, 'ClubSpain::Schema::Result::City');
    is $city -> country_id, 1, 'got country id';
    is $city -> iata, 'MOW', 'got iata';
    is $city -> name, 'Moscow', 'got name';
    is $city -> name_ru, 'Москва', 'got name ru';
    is $city -> is_published, 1, 'got is_published';

    return;
}

sub test_02_fetch :Test(7) {
    my $self = shift;

    my $city = ClubSpain::Model::City -> new(
        id           => 1,
        country_id   => 1,
        iata         => 'zzz',
        name_en      => 'name',
        name_ru      => 'xxx',
        is_published => 1,
    );

    my $object = $city -> fetch_by_id();

    isa_ok( $object, 'ClubSpain::Schema::Result::City' );
    is $object -> id, 1, 'got id';
    is $object -> country_id, 1, 'got country id';
    is $object -> iata, 'MOW', 'got iata code';
    is $object -> name, 'Moscow', 'got name';
    is $object -> name_ru, 'Москва', 'got name ru';
    is $object -> is_published, 1, 'got is_published';

    return;
}

sub test_03_fetch_with_exception :Test {
    my $self = shift;

    try {
        ClubSpain::Model::City -> fetch_by_id(1000);
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
        my $city = ClubSpain::Model::City->new(
            id           => 1000,
            country_id   => 1,
            iata         => 'xxx',
            name_en      => 'some name',
            name_ru      => 'ddd',
            is_published => 1,
        );
        $city -> fetch_by_id();

        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'caught ClubSpain::Exception::Storage');
        is $e -> message, 'Couldn\'t find City: 1000!', 'got message';

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

    try {
        my $city = ClubSpain::Model::City -> new(
            country_id   => 1,
            iata         => 'NYC',
            name_en      => 'new york1',
            name_ru      => 'test',
            is_published => 1,
        );

        my $result = $city -> create();
        pass('no exception thrown');

        isa_ok($result, 'ClubSpain::Schema::Result::City');
        is $result -> country_id, 1, 'got country_id';
        is $result -> iata, 'NYC', 'got iata code';
        is $result -> name, 'new york1', 'got name';
        is $result -> name_ru, 'test', 'got name ru';
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
        my $city = ClubSpain::Model::City -> new(
            country_id   => 2,
            iata         => 'NYV',
            name_en      => 'new york2',
            name_ru      => 'test2',
            is_published => 1,
        );

        my $result = $city->create();
        pass('no exception thrown');

        isa_ok($result, 'ClubSpain::Schema::Result::City');
        is $result -> country_id, 2, 'got country_id';
        is $result -> iata, 'NYV', 'got iata code';
        is $result -> name, 'new york2', 'got name';
        is $result -> name_ru, 'test2', 'got name ru';
        is $result -> is_published, 1, 'got is_published';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub test_06_update :Test(7) {
    my $self = shift;

    my $city = ClubSpain::Model::City -> new(
        id           => 1,
        country_id   => 2,
        iata         => 'MAL',
        name_en      => 'New City name',
        name_ru      => 'New name',
        is_published => 0,
    );

    my $result = $city -> update();

    isa_ok($result, 'ClubSpain::Schema::Result::City');
    is $result -> id, 1, 'got id';
    is $result -> country_id, 2, 'got country id';
    is $result -> iata, 'MAL', 'got iata code';
    is $result -> name, 'New City name', 'got name';
    is $result -> name_ru, 'New name', 'got name ru';
    is $result -> is_published, 0, 'got is_published';

    return;
}

sub test_07_update_call_as_class_method :Test() {
    my $self = shift;

    try {
        ClubSpain::Model::City -> update();
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
        my $city = ClubSpain::Model::City->new(
            id           => 777,
            country_id   => 100,
            iata         => 'MOW',
            name_en      => 'name',
            name_ru      => 'name2',
            is_published => 1,
        );

        $city -> update();
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
        ClubSpain::Model::City -> delete(1000);
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
        my $city = ClubSpain::Model::City -> new(
            id           => 100,
            country_id   => 1,
            iata         => 'xxx',
            name_en      => 'name',
            name_ru      => 'xxx',
            is_published => 0,
        );

        $city -> delete();
        fail( 'no exception thrown' );

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

    my $schema = $self -> { 'schema'} -> schema();
    my $count  = $schema -> resultset( 'City' ) -> search({}) -> count();

    my $city = ClubSpain::Model::City -> new(
        country_id   => 1,
        iata         => 'NNN',
        name_en      => 'New Vasuki',
        name_ru      => 'Васюки',
        is_published => 1,
    );

    my $object = $city->create();
    isa_ok($object, 'ClubSpain::Schema::Result::City');
    is $object->country_id, 1, 'got country id';
    is $object->iata, 'NNN', 'got iata code';
    is $object->name, 'New Vasuki', 'got name';
    is $object->name_ru, 'Васюки', 'got name';
    is $object->is_published, 1, 'got is_published';

    ClubSpain::Model::City -> delete( $object -> id() );

    my $rs = $schema -> resultset( 'City' ) -> search({});
    is $rs -> count(), $count, 'recently added cobject was removed';

    return;
}

1;

__END__