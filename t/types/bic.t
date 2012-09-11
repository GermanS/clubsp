use Test::More tests => 15;
use strict;
use warnings;

use_ok('ClubSpain::Types', qw(BIC));

{
    package MyTypeDecorator;
    use Moose;
    has 'bic'  => ( is => 'rw', isa => 'BIC' );
}

#create object
ok my $type = MyTypeDecorator->new(),
    => 'Created some sort of object';
isa_ok $type, 'MyTypeDecorator'
    => "Yes, it's the correct kind of object";

{
    for my $bic qw(047654321 047654321 047654001 047654002) {
        ok $type->bic($bic)
            => "Assinment bic to $bic";
        is $type->bic, $bic,
            => 'Assignment is correct';
    }

    #exceptions
    {
        {
            eval {
                $type->bic('1234');
                fail('no exception thrown');
            };
            if ($@) {
                my $e;
                if ($e = Exception::Class->caught('ClubSpain::Exception::Validation')) {
                    pass('caught Argument exception. fails to assign bic to 1234');
                } else {
                    fail('other exception thrown');
                }
            }
        }

        {
            eval {
                $type->bic('abcdefghi');
                fail('no exception thrown');
            };
            if ($@) {
                my $e;
                if ($e = Exception::Class->caught('ClubSpain::Exception::Validation')) {
                    pass('caught Argument exception. fails to assign bic to abcdefghi');
                } else {
                    fail('other exception thrown');
                }
            }
        }

        {
            eval {
                $type->bic(undef);
                fail('no exception thrown');
            };
            if ($@) {
                my $e;
                if ($e = Exception::Class->caught('ClubSpain::Exception::Validation')) {
                    pass('caught Argument exception. fails to assign bic to undef');
                } else {
                    fail('other exception thrown');
                }
            }
        }

        #last 3 digits in range 003-049
        {
            eval {
                $type->bic(047654010);
                fail('no exception thrown');
            };
            if ($@) {
                my $e;
                if ($e = Exception::Class->caught('ClubSpain::Exception::Validation')) {
                    pass('caught Argument exception. fails to assign bic to 047654010');
                } else {
                    fail('other exception thrown');
                }
            }
        }
    }
}
