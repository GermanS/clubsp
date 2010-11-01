use Test::More tests => 16;

use strict;
use warnings;

use_ok('ClubSpain::Types');

{
    package Country;
    use Moose;

    has 'name' => (
        is      => 'rw',
        isa     => 'StringLength2to255',
        lazy    => 1,
        default => 0,
    );
}

#positive test
{
    eval {
        Country->new( name => 'Espana' );
        pass('no exception thrown');
    };
}

#negative test
{
    my @tests = ('1', 'a', 0, undef, '', ' ', 'x' x 256 );
    foreach my $argument (@tests) {
        eval {
            Country->new( name => $argument );
            fail('no exception thrown');
        };

        if ($@) {
            my $e;
            if ($e = ClubSpain::Exception::Validation->caught()) {
                pass('caught validation exception');
                is($e->message, "The $argument is less than 2 or more than 255 chars",
                    "check message: $argument"
                );
            } else {
                fail('caught other exception');
            }
        }
    }
}
