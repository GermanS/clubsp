package ClubSpain::Test::Model::BankAccount;

use strict;
use warnings;

use ClubSpain::Model::BankAccount;

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
        company_id            => 1,
        bank                  => 'gazneftbank',
        BIC                   => '044585297',
        current_account       => '40702810900000005219',
        correspondent_account => '30101810500000000297',
    );

    my $account = ClubSpain::Model::BankAccount -> new( %params );

    isa_ok $account, 'ClubSpain::Model::BankAccount';

    is $account -> get_company_id(),            $params{'company_id'},      'got company';
    is $account -> get_bank(),                  $params{'bank'},            'got name of the bank';
    is $account -> get_BIC(),                   $params{'BIC'},             'got bic';
    is $account -> get_current_account(),       $params{'current_account'}, 'got bank account';
    is $account -> get_correspondent_account(), $params{'correspondent_account'}, 'got correspondent account';

    return;
}

sub test_03_fetch_with_exception :Test {
    my $self = shift;

    try {
        ClubSpain::Model::BankAccount -> fetch_by_id(1000);
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
        my $account = ClubSpain::Model::BankAccount -> new(
            id           => 1000,
            company_id            => 1,
            bank                  => 'gazneftbank',
            BIC                   => '044585297',
            current_account       => '40702810900000005219',
            correspondent_account => '30101810500000000297',
        );
        $account -> fetch_by_id();

        fail('no exception thrown');

    } catch( ClubSpain::Exception::Storage $e ) {
        pass( 'caught ClubSpain::Exception::Storage');
        is $e -> message, 'Couldn\'t find BankAccount: 1000!', 'got message';

    } catch( $error ) {
        fail( 'caught other exception' );
        diag $error;
    }

    return;
}

sub test_05_create :Test( 10 ) {
    my $self = shift;

    my %params = (
        company_id            => 1,
        bank                  => 'PSBank',
        BIC                   => '044585297',
        current_account       => '40702810900000005219',
        correspondent_account => '30101810500000000297',
    );

    try {
        my $account = ClubSpain::Model::BankAccount -> new( %params );
        my $result = $account -> create();

        pass('no exception thrown');

        isa_ok $result, 'ClubSpain::Schema::Result::BankAccount';
        is $result -> company_id(),            $params{'company_id'},      'got company id';
        is $result -> bank(),                  $params{'bank'},            'got bank';
        is $result -> BIC(),                   $params{'BIC'},             'got bank identifier code';
        is $result -> current_account(),       $params{'current_account'}, 'got current account';
        is $result -> correspondent_account(), $params{'correspondent_account'}, 'got correspondent account';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    };

    return;
}

sub test_06_update :Test( 8 ) {
    my $self = shift;

    my $account1 = ClubSpain::Model::BankAccount->new(
        company_id => 1,
        bank => 'PSBank',
        BIC  => '047654001',
        current_account       => '12345678901234567890',
        correspondent_account => '12345678901234567890',
        is_published => 0
    );
    my $result1 = $account1 -> create();

    my %params = (
        id                    => $result1 -> id(),
        company_id            => 1,
        bank                  => 'gazneftbank',
        BIC                   => '044585297',
        current_account       => '40702810900000005219',
        correspondent_account => '30101810500000000297',
        is_published          => 0,
    );

    try {
        my $account = ClubSpain::Model::BankAccount -> new( %params );
        my $result = $account -> update();

        isa_ok $result, 'ClubSpain::Schema::Result::BankAccount';

        is $result -> id(),                    $params{'id'},              'got id';
        is $result -> company_id(),            $params{'company_id'},      'got company id';
        is $result -> bank(),                  $params{'bank'},            'got bank';
        is $result -> BIC(),                   $params{'BIC'},             'got BIC';
        is $result -> current_account(),       $params{'current_account'}, 'got current account';
        is $result -> correspondent_account(), $params{'correspondent_account'}, 'got correspondent account';
        is $result -> is_published(),          $params{ 'is_published' }, 'got is_published';

    } catch( $error ) {
        fail( 'caught exception' );
        diag $error;
    }

    return;
}

sub test_07_update_call_as_class_method :Test() {
    my $self = shift;

    try {
        ClubSpain::Model::BankAccount -> update();
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
        my $account = ClubSpain::Model::BankAccount -> new(
            id                    => 1000,
            company_id            => 1,
            bank                  => 'gazneftbank',
            BIC                   => '044585297',
            current_account       => '40702810900000005219',
            correspondent_account => '30101810500000000297',
            is_published          => 0,
        );
        $account -> update();

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
        ClubSpain::Model::BankAccount -> delete(1000);
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
        my $account = ClubSpain::Model::BankAccount -> new(
            id                    => 1000,
            company_id            => 1,
            bank                  => 'gazneftbank',
            BIC                   => '044585297',
            current_account       => '40702810900000005219',
            correspondent_account => '30101810500000000297',
            is_published          => 0,
        );
        $account -> delete();

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
    my $count  = $schema -> resultset( 'BankAccount' ) -> search({}) -> count();

    my %params = (
        company_id            => 1,
        bank                  => 'gazneftbank',
        BIC                   => '044585297',
        current_account       => '40702810900000005219',
        correspondent_account => '30101810500000000297',
        is_published          => 0
    );

    my $account = ClubSpain::Model::BankAccount -> new( %params );
    my $object  = $account -> create();

    isa_ok $object, 'ClubSpain::Schema::Result::BankAccount';
    is $object -> company_id(),            $params{'company_id'},            'got company id';
    is $object -> bank(),                  $params{'bank'},                  'got bank';
    is $object -> BIC(),                   $params{'BIC'},                   'got BIC';
    is $object -> current_account(),       $params{'current_account'},       'got current account';
    is $object -> correspondent_account(), $params{'correspondent_account'}, 'got correspondent account';
    is $object -> is_published(),          $params{ 'is_published' },        'got is published';

    ClubSpain::Model::BankAccount -> delete( $object -> id() );

    my $rs = $schema -> resultset( 'BankAccount' ) -> search({});
    is $rs -> count(), $count, 'no objects left';

    return;
}

1;

__END__