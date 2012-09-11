use Test::More tests => 7;
use strict;
use warnings;
use_ok('ClubSpain::Types', qw(Account));

{
    package MyTypeDecorator;
    use Moose;
    has 'account' => ( is => 'rw', isa => 'Account' );
}

#create object
ok my $type = MyTypeDecorator->new(),
    => 'Created some sort of object';
isa_ok $type, 'MyTypeDecorator'
    => "Yes, it's the correct kind of object";

{
    ok $type->account('12345678901234567890')
        => 'Assigned account to 12345678901234567890';

    is $type->account, '12345678901234567890',
        => 'Assignment is correct';

    #exceptions
    {
        {
            eval {
                $type->account('abc');
                fail('no exception thrown');
            };
            if ($@) {
                my $e;
                if ($e = Exception::Class->caught('ClubSpain::Exception::Validation')) {
                    pass('caught Argument exception. fails to assign account as abc');
                } else {
                    fail('other exception thrown');
                }
            }
        }


        {
            eval {
                $type->account('qwertyuiopqwertyuiop');
                fail('no exception thrown');
            };
            if ($@) {
                my $e;
                if ($e = Exception::Class->caught('ClubSpain::Exception::Validation')) {
                    pass('caught Argument exception. fails to assign account as aqwertyuiop x 2');
                } else {
                    fail('other exception thrown');
                }
            }
        }
    }
}
