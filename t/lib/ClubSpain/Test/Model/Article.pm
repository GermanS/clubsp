package ClubSpain::Test::Model::Article;

use strict;
use warnings;

use ClubSpain::Model::Article;

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

    my $article = ClubSpain::Model::Article->new(
        parent_id       => 0,
        weight          => 1,
        is_published    => 1,
        header          => 'header',
        subheader       => 'subheader',
        body            => 'body',
    );


    isa_ok($article, 'ClubSpain::Model::Article');
    is $article -> get_parent_id,    0, 'got parent_id';
    is $article -> get_weight,       1, 'got weight';
    is $article -> get_is_published, 1, 'got header';
    is $article -> get_header,      'header',    'got header';
    is $article -> get_subheader,   'subheader', 'got subheader';
    is $article -> get_body,        'body',      'got body';

    return;
}

sub test_01_fetch :Test( 7 ) {
    my $self = shift;

    my $story = ClubSpain::Model::Article -> fetch_by_id( 1 );

    isa_ok( $story, 'ClubSpain::Schema::Result::Article' );
    is $story -> parent_id,    0, 'got parent_id';
    is $story -> weight,       1, 'got weight';
    is $story -> is_published, 0, 'got is published';
    is $story -> header,       'HEADER1',    'got header';
    is $story -> subheader,    'SUBHEADER1', 'got subheader';
    is $story -> body,         'BODY1',      'got body';

    return;
}

sub test_02_fetch :Test( 7 ) {
    my $self = shift;

    my $story = ClubSpain::Model::Article -> new(
        id          => 1,
        parent_id   => undef,
        weight      => undef,
        is_published=> undef,
        header      => undef,
        subheader   => undef,
        body        => undef,
    );

    my $object = $story -> fetch_by_id();

    isa_ok($object, 'ClubSpain::Schema::Result::Article');
    is $object -> parent_id,    0, 'got parent_id';
    is $object -> weight,       1, 'got weight';
    is $object -> is_published, 0, 'got is published';
    is $object -> header,      'HEADER1', 'got header';
    is $object -> subheader,   'SUBHEADER1', 'got subheader';
    is $object -> body,        'BODY1', 'got body';

    return;
}

sub test_03_fetch_with_exception :Test {
    my $self = shift;

    try {
        ClubSpain::Model::Article -> fetch_by_id( 1000 );
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
        my $story = ClubSpain::Model::Article->new(
            id          => 1000,
            parent_id   => undef,
            weight      => undef,
            is_published=> undef,
            header      => undef,
            subheader   => undef,
            body        => undef,
        );
        $story -> fetch_by_id();

        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'caught ClubSpain::Exception::Storage');
        is $e -> message, 'Couldn\'t find Article: 1000!', 'got message';

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
        my $article = ClubSpain::Model::Article -> new(
            parent_id    => 0,
            weight       => 10,
            is_published => 1,
            header       => 'header',
            subheader    => 'subheader',
            body         => 'body'
        );

        my $result = $article->create();

        isa_ok($result, 'ClubSpain::Schema::Result::Article');
        is $result -> parent_id,    0, 'got parent id';
        is $result -> is_published, 1, 'got is_published';
        is $result -> weight,       2, 'got weight';
        is $result -> header,      'header',    'got header';
        is $result -> subheader,   'subheader', 'got subheader';
        is $result -> body,        'body',      'got body';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub second_insert {
    my $self = shift;

    try {
        my $article = ClubSpain::Model::Article->new(
            parent_id    => 0,
            weight       => 100,
            is_published => 0,
            header       => 'header2',
            subheader    => 'subheader2',
            body         => 'body2'
        );
        my $result = $article -> create();

        isa_ok($result, 'ClubSpain::Schema::Result::Article');

        is $result -> parent_id,    0, 'got parent id';
        is $result -> is_published, 0, 'got is_published';
        is $result -> weight,       3, 'got weight';
        is $result -> header,       'header2',    'got header';
        is $result -> subheader,    'subheader2', 'got subheader';
        is $result -> body,         'body2',      'got body';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub test_06_update :Test( 8 ) {
    my $self = shift;

    try {
        my $article = ClubSpain::Model::Article -> new(
            id           => 1,
            parent_id    => 0,
            weight       => 10,
            is_published => 1,
            header       => 'new header',
            subheader    => 'new subheader',
            body         => 'new body',
        );

        my $result = $article -> update();

        isa_ok( $result, 'ClubSpain::Schema::Result::Article' );
        is $result -> id,           1, 'got id';
        is $result -> parent_id,    0, 'got parent id';
        is $result -> weight,       10, 'got weight';
        is $result -> is_published, 1, 'got is_published';
        is $result -> header,    'new header',    'got header';
        is $result -> subheader, 'new subheader', 'got subheader';
        is $result -> body,      'new body',      'got body';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    }

    return;
}

sub test_07_update_call_as_class_method :Test() {
    my $self = shift;

    try {
        ClubSpain::Model::Article -> update();
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
        my $article = ClubSpain::Model::Article -> new(
            id           => 100,
            parent_id    => 0,
            weight       => 22,
            is_published => 0,
            header       => 'header',
            subheader    => 'subheader',
            body         => 'body',
        );
        $article -> update();

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
        ClubSpain::Model::Article -> delete( 1000 );
        fail( 'no exception thrown' );

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'Class method: caught Storage exception' );

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    };

    return;
}

sub test_11_delete :Test( 8 ) {
    my $self = shift;

    my $schema = $self -> { 'schema' } -> schema();
    my $count = $schema -> resultset( 'Article' ) -> search({}) -> count();

    my $article = ClubSpain::Model::Article->new(
        parent_id       => 0,
        weight          => 100,
        is_published    => 0,
        header          => 'header',
        subheader       => 'subheader',
        body            => 'body'
    );

    my $object = $article->create();

    isa_ok($object, 'ClubSpain::Schema::Result::Article');
    is $object -> parent_id,    0, 'got parent id';
    is $object -> weight,       4, 'got weight';
    is $object -> is_published, 0, 'got is published';
    is $object -> header,       'header',    'got header';
    is $object -> subheader,    'subheader', 'got subheader';
    is $object -> body,         'body',      'got body';


    ClubSpain::Model::Article -> delete( $object -> id() );

    my $rs = $schema -> resultset( 'Article' ) -> search({});
    is $rs -> count(), $count, 'no objects left';

    return;
}

1;

__END__