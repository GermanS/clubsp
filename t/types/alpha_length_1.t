use Test::More tests => 23;

use strict;
use warnings;

use_ok('ClubSpain::Types', qw(AlphaLength1));

{
    package Country;
    use Moose;

    has 'short' => (
        is      => 'rw',
        isa     => 'AlphaLength1',
        lazy    => 1,
        default => 0,
    );
}


#positive test
{
    eval {
        Country->new( short => 'e' );
        pass('no exception thrown');
    };

    eval {
        Country->new( short => 'B' );
        pass('no exception thrown');
    };
}

#negative test
{
    my @tests = ('1', '33', 'abc', 10, 0, undef, '', ' ', '  ', 'ABC');
    foreach my $argument (@tests) {
        eval {
            Country->new( short => $argument );
            fail('no exception thrown');
        };

        if ($@) {
            my $e;
            if ($e = ClubSpain::Exception::Validation->caught()) {
                pass('caught validation exception');
                is($e->message, sprintf "The %s is not 1 char!", $argument,
                    sprintf "check message: %s", $argument
                );
            } else {
                fail('caught other exception');
            }
        }
    }
}
