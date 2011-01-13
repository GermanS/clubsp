use Test::More tests => 23;

use strict;
use warnings;

use_ok('ClubSpain::Types');

{
    package Country;
    use Moose;

    has 'short' => (
        is      => 'rw',
        isa     => 'AlphaNumericLength2',
        lazy    => 1,
        default => 0,
    );
}


#positive test
{

    my @tests = ('aa', 'AA', 'a7', '77', '7a', 'S7');
    foreach my $test (@tests) {
        eval {
            Country->new( short => $test );
            pass('no exception thrown');
        };

        if ($@) {
            my $e;
            if ($e = ClubSpain::Exception::Validation->caught()) {
                fail('caught validation exception');
                diag $@;
            } else {
                fail('caught other exception');
                diag $@;
            }
        }
    }
}

#negative test
{
    my @tests = ('a', ' *', 'abc', 0, '', '()', '\as', 'AB7');
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
