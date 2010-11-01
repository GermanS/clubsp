use Test::More tests => 22;

use strict;
use warnings;

use_ok('ClubSpain::Types');

{
    package Country;
    use Moose;

    has 'short' => (
        is      => 'rw',
        isa     => 'AlphaLength2',
        lazy    => 1,
        default => 0,
    );
}


#positive test
{
    eval {
        Country->new( short => 'es' );

        pass('no exception thrown');
    };
}

#negative test
{
    my @tests = ('a', 'a1', '33', 'abc', 10, 0, undef, '', ' ', '  ');
    foreach my $argument (@tests) {
        eval {
            Country->new( short => $argument );
            fail('no exception thrown');
        };

        if ($@) {
            my $e;
            if ($e = ClubSpain::Exception::Validation->caught()) {
                pass('caught validation exception');
                is($e->message, "The $argument is not 2 chars word!",
                    "check message: $argument"
                );
            } else {
                fail('caught other exception');
            }
        }
    }
}
