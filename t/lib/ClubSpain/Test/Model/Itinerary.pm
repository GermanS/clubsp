package ClubSpain::Test::Model::Itinerary;

use strict;
use warnings;

use ClubSpain::Model::Itinerary;

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

    my $itinerary = ClubSpain::Model::Itinerary->new(
        is_published   => 1,
        timetable_id   => 1,
        fare_class_id  => 2,
        parent_id      => 0,
        cost           => 100
    );

    isa_ok($itinerary, 'ClubSpain::Model::Itinerary');
    is $itinerary -> get_timetable_id,  1, 'got timetable id';
    is $itinerary -> get_fare_class_id, 2, 'got fare class id';
    is $itinerary -> get_parent_id,     0, 'got fare id';
    is $itinerary -> get_cost,          100, 'got cost';
    is $itinerary -> get_is_published,  1,   'got is_published';

    return;
}

sub test_01_fetch :Test( 6 ) {
    my $self = shift;

    my $itinerary = ClubSpain::Model::Itinerary -> fetch_by_id(1);

    isa_ok($itinerary, 'ClubSpain::Schema::Result::Itinerary');
    is $itinerary -> timetable_id,  7, 'got timetable id';
    is $itinerary -> fare_class_id, 1, 'got fare class id';
    is $itinerary -> parent_id,     0, 'got parent id';
    is $itinerary -> cost,          175, 'got cost';
    is $itinerary -> is_published,  1,   'got is published';

    return;
}

sub test_02_fetch :Test( 6 ) {
    my $self = shift;

    my $itinerary = ClubSpain::Model::Itinerary -> new(
        id            => 1,
        timetable_id  => 0,
        fare_class_id => 0,
        parent_id     => 0,
        cost          => 0,
        is_published  => 0,
    );

    my $object = $itinerary -> fetch_by_id();

    isa_ok($object, 'ClubSpain::Schema::Result::Itinerary');

    is $object -> timetable_id,  7, 'got timetable id';
    is $object -> fare_class_id, 1, 'got fare class id';
    is $object -> parent_id,     0, 'got parent id';
    is $object -> cost,        175, 'got cost';
    is $object -> is_published,  1, 'got is_published';

    return;
}

sub test_03_fetch_with_exception :Test {
    my $self = shift;

    try {
        ClubSpain::Model::Itinerary -> fetch_by_id( 1000 );
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
        my $itinerary = ClubSpain::Model::Itinerary -> new(
            id            => 1000,
            timetable_id  => 0,
            fare_class_id => 0,
            parent_id     => 0,
            cost          => 0,
            is_published  => 0,
        );
        $itinerary -> fetch_by_id();

        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'caught ClubSpain::Exception::Storage');
        is $e -> message, 'Couldn\'t find Itinerary: 1000!', 'got message';

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    }

    return;
}

sub test_05_create :Test( 12 ) {
    my $self = shift;

    $self -> first_insert();
    $self -> second_insert();

    return;
}

sub first_insert {
    my $self = shift;

    try {
        my $itinerary = ClubSpain::Model::Itinerary -> new(
            timetable_id  => 1,
            fare_class_id => 1,
            parent_id     => 0,
            cost          => 100,
            is_published  => 1,
        );
        my $result = $itinerary -> create();

        isa_ok($result, 'ClubSpain::Schema::Result::Itinerary');

        is $result -> timetable_id,  1, 'got timetable id';
        is $result -> fare_class_id, 1, 'got fare class id';
        is $result -> parent_id,     0, 'got parent';
        is $result -> cost,        100, 'got cost';
        is $result -> is_published,  1, 'got is published';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub second_insert {
    my $self = shift;

    try {
        my $itinerary = ClubSpain::Model::Itinerary -> new(
            timetable_id  => 2,
            fare_class_id => 2,
            parent_id     => 0,
            cost          => 0,
            is_published  => 1,
        );

        my $result = $itinerary -> create();

        isa_ok($result, 'ClubSpain::Schema::Result::Itinerary');
        is $result -> timetable_id,  2, 'got timetable id';
        is $result -> fare_class_id, 2, 'got fare class id';
        is $result -> parent_id,     0, 'got parent id';
        is $result -> cost,          0, 'got cost';
        is $result -> is_published,  1, 'got is_published';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub test_06_update :Test( 7 ) {
    my $self = shift;

    try {
        my $itinerary = ClubSpain::Model::Itinerary -> new(
            id            => 1,
            timetable_id  => 7,
            fare_class_id => 2,
            parent_id     => 0,
            cost          => 200,
            is_published  => 1,
        );

        my $result = $itinerary -> update();

        isa_ok($result, 'ClubSpain::Schema::Result::Itinerary');
        is $result -> id,            1, 'got id';
        is $result -> timetable_id,  7, 'got timetable id';
        is $result -> fare_class_id, 2, 'got fare class id';
        is $result -> parent_id,     0, 'got parent id';
        is $result -> cost,        200, 'got cost';
        is $result -> is_published,  1, 'got is_published';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    }

    return;
}

sub test_07_update_call_as_class_method :Test() {
    my $self = shift;

    try {
        ClubSpain::Model::Itinerary -> update();
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
        my $itinerary = ClubSpain::Model::Itinerary -> new(
            id            => 777,
            timetable_id  => 0,
            fare_class_id => 0,
            parent_id     => 0,
            cost          => 0,
            is_published  => 1,
        );
        $itinerary -> update();

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
        ClubSpain::Model::Itinerary -> delete( 1000 );
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
        my $itinerary = ClubSpain::Model::Itinerary -> new(
            id            => 230,
            timetable_id  => 1,
            fare_class_id => 1,
            parent_id     => 0,
            cost          => 0,
            is_published  => 1,
        );
        $itinerary -> delete();

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
    my $count = $schema -> resultset( 'Itinerary' ) -> search({}) -> count();

    my $itinerary = ClubSpain::Model::Itinerary -> new(
        timetable_id  => 1,
        fare_class_id => 1,
        parent_id     => 0,
        cost          => 100,
        is_published  => 1,
    );

    my $object = $itinerary -> create();

    isa_ok($object, 'ClubSpain::Schema::Result::Itinerary');
    is $object -> timetable_id,  1, 'got timetable id';
    is $object -> fare_class_id, 1, 'got fare class id';
    is $object -> parent_id,     0, 'got parent id';
    is $object -> cost,        100, 'got cost';
    is $object -> is_published,  1, 'got is_published';


    ClubSpain::Model::Itinerary -> delete( $object -> id() );

    my $rs = $schema -> resultset( 'Itinerary' ) -> search({});
    is $rs -> count(), $count, 'no objects left';

    return;
}


sub test_12_insert_fare: Test( 14 ) {
    my $self = shift;

    $self -> insert_OW();
    $self -> insert_RT();

    return;
}

sub insert_OW {
    my $self = shift;

    try {
        my $itinerary = ClubSpain::Model::Itinerary -> new(
            timetable_id  => 1,
            return_segment=> 0,
            fare_class_id => 1,
            parent_id     => 0,
            cost          => 550,
            is_published  => 1,
        );

        my $result = $itinerary -> insert_fare();
        pass('no exception thrown');

        isa_ok($result, 'ClubSpain::Schema::Result::Itinerary');
        is $result -> timetable_id,  1, 'got timetable id';
        is $result -> fare_class_id, 1, 'got fare class id';
        is $result -> parent_id,     0, 'got parent';
        is $result -> cost,        550, 'got cost';
        is $result -> is_published,  1, 'got is published';

    } catch ( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub insert_RT {
    my $self = shift;

    try {
        my $itinerary = ClubSpain::Model::Itinerary->new(
            timetable_id  => 1,
            return_segment=> 2,
            fare_class_id => 1,
            parent_id     => 0,
            cost          => 990,
            is_published  => 1,
        );

        my $result = $itinerary -> insert_fare();
        pass( 'no exception thrown' );

        isa_ok( $result, 'ClubSpain::Schema::Result::Itinerary' );
        is $result -> timetable_id,  1, 'got timetable id';
        is $result -> fare_class_id, 1, 'got fare class id';
        is $result -> parent_id,     0, 'got parent';
        is $result -> cost,        990, 'got cost';
        is $result -> is_published,  1, 'got is published';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub test_13_update_fare :Test( 22 ) {
    my $self = shift;

    $self -> update_OW();
    $self -> update_RT();

    return;
}

sub update_OW {
    my $self = shift;

    try {
        my $fare = ClubSpain::Model::Itinerary -> new(
            id            => 1,
            timetable_id  => 7,
            fare_class_id => 2,
            parent_id     => 0,
            cost          => 500,
            is_published  => 1,
        );

        my $result = $fare -> update();

        pass( 'no exception thrown' );

        isa_ok( $result, 'ClubSpain::Schema::Result::Itinerary');
        is $result -> id, 1, 'got id';
        is $result -> timetable_id,  7, 'got timetable id';
        is $result -> fare_class_id, 2, 'got fare class id';
        is $result -> parent_id,     0, 'got parent id';
        is $result -> cost,        500, 'got cost';
        is $result -> is_published,  1, 'got is_published';

        ok(!$result->next_route, 'OW tarif');

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    }

    return;
}

sub update_RT {
    my $self = shift;

    try {
        my $fare = ClubSpain::Model::Itinerary->new(
            id            => 5,
            timetable_id  => 7,
            fare_class_id => 2,
            cost          => 1234,
            is_published  => 0,
        );

        my $result = $fare -> update_fare();

        isa_ok( $result, 'ClubSpain::Schema::Result::Itinerary' );
        is $result -> id,            5, 'got id';
        is $result -> timetable_id,  7, 'got timetable id';
        is $result -> fare_class_id, 2, 'got fare class id';
        is $result -> parent_id,     0, 'got parent id';
        is $result -> cost,       1234, 'got cost';
        is $result -> is_published,  0, 'got is_published';

        my $return = $result -> next_route();

        isa_ok( $return, 'ClubSpain::Schema::Result::Itinerary' );
        ok($return, 'RT tarif');
        is $return -> parent_id,     5,  'check consistency';
        is $return -> fare_class_id, $result -> fare_class_id, 'fare clases are equal';
        is $return -> cost,          0, 'the cost or return segment equals to 0';
        is $return -> is_published,  $result -> is_published, 'is published flags are equal';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    }

    return;
}

sub test_14_delete_fare :Test( 7 ) {
    my $self = shift;

    my $schema = $self -> { 'schema' } -> schema();
    my $count  = $schema -> resultset( 'Itinerary' ) -> search({}) -> count();

    my $itinerary = ClubSpain::Model::Itinerary -> new(
        timetable_id  => 1,
        return_segment=> 2,
        fare_class_id => 1,
        parent_id     => 0,
        cost          => 100,
        is_published  => 1,
    );

    my $object = $itinerary -> insert_fare();

    isa_ok($object, 'ClubSpain::Schema::Result::Itinerary');
    is $object -> timetable_id,  1, 'got timetable id';
    is $object -> fare_class_id, 1, 'got fare class id';
    is $object -> parent_id,     0, 'got parent id';
    is $object -> cost,        100, 'got cost';
    is $object -> is_published,  1, 'got is_published';


    ClubSpain::Model::Itinerary -> delete_fare( $object -> id() );

    my $rs = $schema -> resultset( 'Itinerary' ) -> search({});
    is( $rs -> count, $count, 'no objects left' );

    return;
}

1;

__END__