use Test::More tests => 12;
use strict;
use warnings;

use_ok('ClubSpain::Types', qw(INN));

{
    package MyTypeDecorator;
    use Moose;
    has 'inn' => ( is => 'rw', isa => 'INN' );
}

ok my $type = MyTypeDecorator->new(),
    => 'Created some sort of object';

isa_ok $type, 'MyTypeDecorator'
    => "Yes, it's the correct kind of object";

{
    for my $inn qw(7702581366 7701833652 673002363905 504308599677) {
        ok $type->inn($inn)
            => "Assinment inn to $inn";
        is $type->inn, $inn,
            => 'Assignment is correct';
    }

    #exceptions
    {
        eval {
            $type->inn(12345678);
            fail('no exception thrown (INN)');
        };

        if ($@) {
            if (my $e = Exception::Class->caught('ClubSpain::Exception::Validation')) {
                pass('caught argument exception (INN)');
            } else {
                fail('caught other exception');
            }

        }
    }
}
