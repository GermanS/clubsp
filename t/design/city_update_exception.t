use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::Model::City');

#call as class method
{
    eval {
        ClubSpain::Model::City->update();
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

#object does not exists in database
{
    my $city = ClubSpain::Model::City->new(
        id           => 777,
        country_id   => 100,
        name         => 'name',
        is_published => 1,
    );

    eval {
        $city->update();
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
