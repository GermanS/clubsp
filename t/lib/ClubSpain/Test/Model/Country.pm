package ClubSpain::Test::Model::Country;

use strict;
use warnings;

use ClubSpain::Model::Country;

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

sub test_00_simple :Test(7) {
    my $self = shift;

    my $country = ClubSpain::Model::Country->new(
        name         => 'Russia',
        alpha2       => 'ru',
        alpha3       => 'rus',
        numerics     => 7,
        is_published => 1,
    );

    isa_ok($country, 'ClubSpain::Model::Country');
    is $country -> get_id(), undef, 'id not set';
    is $country -> get_name(), 'Russia', 'got name';
    is $country -> get_alpha2(), 'ru', 'got aplha2';
    is $country -> get_alpha3(), 'rus', 'got aplha3';
    is $country -> get_numerics(), 7, 'Got numerics';
    is $country -> get_is_published(), 1, 'got is_published';

    return;
}

sub test_01_fetch :Test(6) {
    my $self = shift;

    my $country = ClubSpain::Model::Country -> fetch_by_id(1);

    isa_ok($country, 'ClubSpain::Schema::Result::Country');
    is $country -> name(), 'Russia', 'got name';
    is $country -> alpha2(), 'ru', 'got alpha2';
    is $country -> alpha3(), 'rus', 'got alpha3';
    is $country -> numerics(), 7, 'got numerics';
    is $country -> is_published(), 1, 'got is_published';

    return;
}

sub test_02_fetch :Test(7) {
    my $self = shift;

    my $country = ClubSpain::Model::Country -> new(
        id           => 1,
        name         => 'RF',
        alpha2       => 'RR',
        alpha3       => 'RRS',
        numerics     => 70,
        is_published => 1,
    );

    my $object = $country -> fetch_by_id();

    isa_ok($object, 'ClubSpain::Schema::Result::Country');
    is $object -> id(), 1, 'got id';
    is $object -> name(), 'Russia', 'got name';
    is $object -> alpha2(), 'ru', 'got alpha2';
    is $object -> alpha3(), 'rus', 'got alpha3';
    is $object -> numerics(), 7, 'got numerics';
    is $object -> is_published(), 1, 'got is_published';

    return;
}

sub test_03_fetch_with_exception :Test {
    my $self = shift;

    try {
        ClubSpain::Model::Country -> fetch_by_id(1000);
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
        my $country = ClubSpain::Model::Country->new(
            id => 1000,
            name    => 'russia',
            alpha2  => 'ru',
            alpha3  => 'rus',
            numerics => 7,
            is_published => 1,
        );

        $country -> fetch_by_id();

        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'caught ClubSpain::Exception::Storage');
        is $e -> message, 'Couldn\'t find Country: 1000!', 'got message';

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    }

    return;
}

sub test_05_create :Test(7) {
    my $self = shift;

    try {
        my $country = ClubSpain::Model::Country -> new(
            name         => 'USA',
            alpha2       => 'us',
            alpha3       => 'usa',
            numerics     => 1,
            is_published => 1,
        );

        my $result = $country -> create();
        pass('no exception thrown');

        isa_ok($result, 'ClubSpain::Schema::Result::Country');
        is $result -> name(), 'USA', 'got name';
        is $result -> alpha2(), 'us', 'got alpha2';
        is $result -> alpha3(), 'usa', 'got alpha3';
        is $result -> numerics(), '1', 'got numerics';
        is $result -> is_published(), 1, 'got is_published';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub test_06_update :Test(7) {
    my $self = shift;

    my $country = ClubSpain::Model::Country -> new(
        id           => 1,
        name         => 'Soviet union',
        alpha2       => 'su',
        alpha3       => 'suu',
        numerics     => '123',
        is_published => 1,
    );

    my $result = $country -> update();

    isa_ok($result, 'ClubSpain::Schema::Result::Country');
    is $result -> id(), 1, 'got id';
    is $result -> name(), 'Soviet union','got name';
    is $result -> alpha2(), 'su', 'got alpha2';
    is $result -> alpha3(), 'suu', 'got alpha3';
    is $result -> numerics(), 123, 'got numerics';
    is $result -> is_published(), 1, 'got is_published';

    return;
}

sub test_07_update_call_as_class_method :Test() {
    my $self = shift;

    try {
        ClubSpain::Model::Country -> update();
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
        my $country = ClubSpain::Model::Country->new(
            id           => '777',
            name         => 'soviet union',
            alpha2       => 'su',
            alpha3       => 'suu',
            numerics     => 777,
            is_published => 1,
        );

        $country -> update();
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
        ClubSpain::Model::Country -> delete(1000);
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
        my $country = ClubSpain::Model::Country->new(
            id           => 1000,
            name         => 'soviet union',
            alpha2       => 'su',
            alpha3       => 'suu',
            numerics     => 777,
            is_published => 1,
        );
        $country -> delete();
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

    my $schema = $self -> { 'schema' } -> schema();
    my $count = $schema -> resultset( 'Country' ) -> search({}) -> count();

    my $country = ClubSpain::Model::Country -> new(
        name         => 'RF',
        alpha2       => 'rf',
        alpha3       => 'rus',
        numerics     => 7,
        is_published => 1,
    );

    my $object = $country -> create();

    isa_ok($object, 'ClubSpain::Schema::Result::Country');
    is $object -> name, 'RF', 'got name';
    is $object -> alpha2, 'rf', 'got alpha2';
    is $object -> alpha3, 'rus', 'got aplha3';
    is $object -> numerics, 7, 'got numerics';
    is $object -> is_published, 1, 'got is_published';

    ClubSpain::Model::Country -> delete( $object -> id() );

    my $rs = $schema -> resultset( 'Country' ) -> search({});
    is $rs -> count(), $count, 'no objects left';

    return;
}

1;