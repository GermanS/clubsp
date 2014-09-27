package ClubSpain::Test::Model::Office;

use strict;
use warnings;

use ClubSpain::Model::Office;

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
        company_id   => 1,
        zipcode      => 123456,
        street       => 'Address 20',
        name         => 'Office 1',
        is_published => 1,
    );

    my $office = ClubSpain::Model::Office -> new( %params );

    isa_ok $office, 'ClubSpain::Model::Office';
    is $office -> get_company_id(),   $params{ 'company_id' },   'got company id';
    is $office -> get_zipcode(),      $params{ 'zipcode' },      'got zipcode';
    is $office -> get_name(),         $params{ 'name' },         'got name';
    is $office -> get_street(),       $params{ 'street' },       'got street';
    is $office -> get_is_published(), $params{ 'is_published' }, 'got is published flag';

    return;
}

sub test_03_fetch_with_exception :Test {
    my $self = shift;

    try {
        ClubSpain::Model::Office -> fetch_by_id(1000);
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
        my $office = ClubSpain::Model::Office -> new(
            id           => 1000,
            company_id   => 1,
            zipcode      => 123456,
            street       => 'Address 20',
            name         => 'Office 1',
            is_published => 1,
        );
        $office -> fetch_by_id();

        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'caught ClubSpain::Exception::Storage');
        is $e -> message, 'Couldn\'t find Office: 1000!', 'got message';

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    }

    return;
}

sub test_05_create :Test( 7 ) {
    my $self = shift;

    my %params = (
        company_id  => 1,
        zipcode     => 123456,
        street      => 'Babushkinskaya 7',
        name        => 'central office',
        is_published => 1,
    );

    try {
        my $office = ClubSpain::Model::Office -> new( %params );
        my $result = $office -> create();

        pass( 'no exception thrown' );

        isa_ok( $result, 'ClubSpain::Schema::Result::Office' );
        is $result -> company_id(),   $params{ 'company_id' },   'got company id';
        is $result -> zipcode(),      $params{ 'zipcode' },      'got zipcode';
        is $result -> street(),       $params{ 'street' },       'got street';
        is $result -> name(),         $params{ 'name' },         'got name';
        is $result -> is_published(), $params{ 'is_published' }, 'got is published';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}


sub test_06_update :Test(6) {
    my $self = shift;

    my $office1 = ClubSpain::Model::Office -> new(
        company_id  => 1,
        zipcode     => 654321,
        street      => 'Address 22',
        name        => 'Office 3',
        is_published => 0,
    );
    my $result1 = $office1 -> create();

    my %params = (
        id          => $result1 -> id(),
        company_id  => 1,
        zipcode     => 123456,
        street      => 'Address 20',
        name        => 'Office 1',
        is_published => 1,
    );

    try {
        my $office = ClubSpain::Model::Office -> new( %params );
        my $result = $office -> update();

        isa_ok($result, 'ClubSpain::Schema::Result::Office');
        is $result -> company_id(),   $params{ 'company_id' },   'got company id';
        is $result -> zipcode(),      $params{ 'zipcode' },      'got zipcode';
        is $result -> name(),         $params{ 'name' },         'got name';
        is $result -> street(),       $params{ 'street' },       'got street';
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
        ClubSpain::Model::Office -> update();
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
        my $office = ClubSpain::Model::Office -> new(
            id           => 777,
            company_id   => 1,
            zipcode      => 123456,
            street       => 'Address 20',
            name         => 'Office 1',
            is_published => 1,
        );
        $office -> update();

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
        ClubSpain::Model::Office -> delete(1000);
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
        my $office = ClubSpain::Model::Office -> new(
            id           => 23,
            company_id   => 1,
            zipcode      => 123456,
            street       => 'Address 20',
            name         => 'Office 1',
            is_published => 1,
        );
        $office -> delete();

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
    my $count  = $schema -> resultset( 'Office' ) -> search({}) -> count();

    my %params = (
        company_id   => 1,
        zipcode      => 123456,
        street       => 'Babushkinskaya 7',
        name         => 'central office',
        is_published => 1,
    );

    my $office = ClubSpain::Model::Office -> new( %params );
    my $result = $office -> create();

    isa_ok $result, 'ClubSpain::Schema::Result::Office';
    is $result -> company_id(),   $params{ 'company_id' },   'got company id';
    is $result -> zipcode(),      $params{ 'zipcode' },      'got zipcode';
    is $result -> street(),       $params{ 'street' },       'got street';
    is $result -> name(),         $params{ 'name' },         'got name';
    is $result -> is_published(), $params{ 'is_published' }, 'got is published';

    ClubSpain::Model::Office -> delete( $result -> id() );

    my $rs = $schema -> resultset( 'Office' ) -> search({});
    is $rs -> count(), $count, 'no objects left';

    return;
}

1;

__END__