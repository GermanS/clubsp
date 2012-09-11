use Test::More tests => 10;
use strict;
use warnings;

use_ok('ClubSpain::Types', qw(OKPO));

{
    package MyTypeDecorator;
    use Moose;

    has 'okpo' => ( is => 'rw', isa => 'OKPO' );
}

#create object
ok my $type = MyTypeDecorator->new(),
    => 'Created some sort of object';
isa_ok $type, 'MyTypeDecorator'
    => "Yes, it's the correct kind of object";

{
    for my $okpo qw(79011171 7901117001 0154489581) {
        ok $type->okpo($okpo)
            => "Assignment okpo to $okpo";
        is $type->okpo, $okpo,
            => 'Assignment is correct';
    }

    #exceptions
    {
        eval {
            $type->okpo(1201117124);
            fail('no exception thrown (OKPO)');
        };

        if ($@) {
            if (my $e = Exception::Class->caught('ClubSpain::Exception::Validation')) {
                pass('caught argument exception (OKPO)');
            } else {
                fail('caught other exception');
            }

        }
    }
}
