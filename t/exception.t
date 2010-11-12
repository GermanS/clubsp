use Test::More tests => 7;

use strict;
use warnings;

use_ok("ClubSpain::Exception");

#test message propagation
{

    foreach (qw(Storage Validation Argument)) {
        my $class = 'ClubSpain::Exception::' . $_;

        eval {
            $class->throw(message => 'foo');
            fail('no exception thrown');
        };

        if ($@) {
            my $e;
            if ($e = Exception::Class->caught($class)) {
                pass("caught $class exception");
                is($e->message, 'foo', 'get "foo" message');
            } else {
                fail('other exception thrown');
            }
        }
    }
}
