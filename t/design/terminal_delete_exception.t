use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::Model::Terminal');

{
    eval {
        ClubSpain::Model::Terminal->delete(1000);
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('Class method: caught Storage exception');
        } else {
            fail('cought other exception');
            diag $@;
        }
    }
}

{
    my $terminal = ClubSpain::Model::Terminal->new(
        id          => 23,
        airport_id  => 'bar',
        name        => 'foo bar',
        is_published=> 0,
    );

    eval {
        $terminal->delete();
        fail('no exception thrown');
    };

    if ($@) {
        my $e;
        if($e = Exception::Class->caught('ClubSpain::Exception::Storage')) {
            pass('Object Method: caught Storage exception');
        } else {
            fail('cought other exception');
            diag $@;
        }
    }
}
