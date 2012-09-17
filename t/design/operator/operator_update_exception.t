use Test::More tests => 3;
use strict;
use warnings;

use_ok('ClubSpain::Model::Operator');

#call as class method
{
    eval {
        ClubSpain::Model::Operator->update();
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Argument')) {
            pass('caught Argument exception');
        } else {
            diag ($@);
            fail('caught other exception');
        }
    }
}

#object does not exist in database
{
    my $operator = ClubSpain::Model::Operator->new(
        id          => 777,
        office_id   => 1,
        name        => 'Jose',
        surname     => 'Cuesta',
        email       => 'info@mail.com',
        passwd      => 'passwd',
        mobile      => '9105458224',
        is_published => 1,
    );

    eval {
        $operator->update();
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if ($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('caught Storage exception');
        } else {
            fail('caught other exception');
            diag $@;
        }
    }
}
