use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::Model::Article');

{
    eval {
        ClubSpain::Model::Article->delete(1000);
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
    my $article = ClubSpain::Model::Article->new(
        id          => 100,
        parent_id   => 0,
        weight      => 22,
        is_published=> 0,
        header      => 'header',
        subheader   => 'subheader',
        body        => 'body'
    );

    eval {
        $article->delete();
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
