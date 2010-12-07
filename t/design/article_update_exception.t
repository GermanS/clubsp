use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::Design::Article');

#call as class method
{
    eval {
        ClubSpain::Design::Article->update();
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
    my $article = ClubSpain::Design::Article->new(
        id          => 100,
        parent_id   => 0,
        weight      => 22,
        is_published=> 0,
        header      => 'header',
        subheader   => 'subheader',
        body        => 'body'
    );

    eval {
        $article->update();
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
