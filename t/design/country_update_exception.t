use Test::More tests => 2;

use strict;
use warnings;

use_ok('ClubSpain::Design::Country');

#call as class method
{
    eval {
        ClubSpain::Design::Country->update();
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
