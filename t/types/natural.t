use Test::More tests => 12;

use strict;
use warnings;

use_ok('ClubSpain::Types');

{
    package Person;
    use Moose;

    has 'years' => (
        is      => 'rw',
        isa     => 'Natural',
        lazy    => 1,
        default => 0,
    );
}

#positive test
{
    eval {
        Person->new( years => 4 );
        pass('no exception thrown');
    };
}


# negative test
{
    my @tests = (0, -1, 'abc', 0.01, "1000,0");
    foreach my $argument (@tests) {
        eval {
            Person->new( years => $argument );
            fail('no exception thrown');
        };

        if ($@) {
            my $e;
            if ($e = ClubSpain::Exception::Validation->caught()) {
                pass('caught validation exception');
                is($e->message, "This number $argument is not a positive integer!",
                    "check message: $argument"
                )
            } else {
                fail('other exception thrown');
            }
        }
    }
}
