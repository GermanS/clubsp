use Test::More tests => 25;

use strict;
use warnings;

use_ok('ClubSpain::Types');

{
    package Country;
    use Moose;

    has 'short' => (
        is      => 'rw',
        isa     => 'AlphaLength3',
        lazy    => 1,
        default => 0,
    );
}


#positive test
{
    eval {
        Country->new( short => 'esp' );
        pass('no exception thrown');
    };

    eval {
        Country->new( short => 'ESP' );
        pass('no exception thrown');
    };
}

#negative test
{
    my @tests = ('1', '33', 10, 0, undef, '', ' ', '   ', 'abcd', 'a3b', 'ABCD');
    foreach my $argument (@tests) {
        eval {
            Country->new( short => $argument );
            fail('no exception thrown');
        };

        if ($@) {
            my $e;
            if ($e = ClubSpain::Exception::Validation->caught()) {
                pass('caught validation exception');
                is($e->message, "The $argument is not 3 chars word!",
                    "check message: $argument"
                );
            } else {
                fail('caught other exception');
            }
        }
    }
}
