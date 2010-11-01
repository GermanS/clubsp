use Test::More tests => 14;

use strict;
use warnings;

use_ok('ClubSpain::Types');

{
    package Person;
    use Moose;

    has 'years' => (
        is      => 'rw',
        isa     => 'NaturalLessThan1000',
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
    my @tests = (0, -1, 'abc', 0.01, "1000,0", 1000);
    foreach my $argument (@tests) {
        eval {
            Person->new( years => $argument );
            fail('no exception thrown');
        };

        if ($@) {
            my $e;
            if ($e = ClubSpain::Exception::Validation->caught()) {
                pass('caught validation exception');
                is($e->message, "This number $argument is not less than 1000!",
                    "check message: $argument"
                )
            } else {
                fail('other exception thrown');
            }
        }
    }
}
