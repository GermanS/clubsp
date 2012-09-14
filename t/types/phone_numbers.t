use Test::More tests => 13;
use strict;
use warnings;

use_ok('ClubSpain::Types');

{
    package MyTypeDecorator;
    use Moose;
    has 'local'  => ( is => 'rw', isa =>'LocalPhoneNumber' );
    has 'mobile' => ( is => 'rw', isa =>'MobilePhoneNumber' );
}

#create object
ok my $type = MyTypeDecorator->new(),
    => 'Created some sort of object';
isa_ok $type, 'MyTypeDecorator'
    => "Yes, it's the correct kind of object";

{
    ok $type->local(4991234567)
        => "Assignment local phone number";
    is $type->local, 4991234567
        => 'got the right phone number';

    ok $type->mobile(9101234567)
        => 'Assignment mobile phone number';
    is $type->mobile, 9101234567
        => 'got the right mobile number';
}

#exceptions
{

    {
        foreach my $local qw(123 12345678901 9017654321) {
            eval {
                $type->local($local);
                fail('no exception thrown');
            };
            if ($@) {
                my $e;
                if ($e = Exception::Class->caught('ClubSpain::Exception::Validation')) {
                    pass("caught Argument exception. fails to assign local to $local");
                } else {
                    fail('other exception thrown');
                }
            }
        }

        foreach my $mobile qw(123 98765432101 8442123456) {
            eval {
                $type->mobile($mobile);
                fail('no exception thrown');
            };
            if ($@) {
                my $e;
                if ($e = Exception::Class->caught('ClubSpain::Exception::Validation')) {
                    pass("caught Argument exception. fails to assign mobile to $mobile");
                } else {
                    fail('other exception thrown');
                }
            }
        }
    }
}


