use Test::More tests => 27;

use strict;
use warnings;

use_ok('ClubSpain::Types');

{
    package Country;
    use Moose;

    has 'short' => (
        is      => 'rw',
        isa     => 'AlphaNumericLength3',
        lazy    => 1,
        default => 0,
    );
}


#positive test
{

    my @tests = ('aaa', 'AaA', 'a77', '775', '7ea', 'S27');
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
    my @tests = ('a', ' *', 'a b c', 0, '', '( )', '\as', 'AB ', 'abcd', 'abc d');
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
