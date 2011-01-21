use Test::More tests => 16;

use strict;
use warnings;

use_ok('ClubSpain::Types');

{
    package Person;
    use Moose;

    has 'years' => (
        is      => 'rw',
        isa     => 'NaturalLessThan10000',
        lazy    => 1,
        default => 0,
    );
}

#positive test
{
    eval {
        Person->new( years => 999 );
        pass('no exception thrown');
    };
}


# negative test
{
    my @tests = (0, -1, 'abc', 0.01, "10000,0", 10000, '88 45');
    foreach my $argument (@tests) {
        eval {
            Person->new( years => $argument );
            fail('no exception thrown');
        };

        if ($@) {
            my $e;
            if ($e = ClubSpain::Exception::Validation->caught()) {
                pass('caught validation exception');
                is($e->message, "This number $argument is not less than 10000!",
                    "check message: $argument"
                )
            } else {
                fail('other exception thrown');
            }
        }
    }
}
