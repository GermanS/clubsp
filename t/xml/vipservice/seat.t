use Test::More tests => 14;

use strict;
use warnings;

use_ok('ClubSpain::XML::VipService::Seat');

{
    my $seat = ClubSpain::XML::VipService::Seat -> new();
    isa_ok($seat, 'ClubSpain::XML::VipService::Seat::Adult');

    is $seat -> passenger, 'ADULT'
        => 'got passenger';

    is $seat -> count, 0
        => 'got count';

    is $seat -> is_adult(), 1
        => 'the passanger is adult';

    isnt $seat -> is_child(), 1
        => 'the passanger is not child';

    isnt $seat -> is_infant(), 1
        => 'the passenger is not infant';
}

{
    my $seat = ClubSpain::XML::VipService::Seat -> new(
        passenger => 'CHILD',
        count     => 1
    );
    isa_ok($seat, 'ClubSpain::XML::VipService::Seat::Child');

    is $seat -> passenger, 'CHILD'
        => 'got passenger';

    is $seat -> count, 1
        => 'got count';

    isnt $seat -> is_adult(), 1
        => 'the passanger is not adult';

    is $seat -> is_child(), 1
        => 'the passanger is child';

    isnt $seat -> is_infant(), 1
        => 'the passenger is not infant';
}

#to_hash()
{
    my $seat = ClubSpain::XML::VipService::Seat -> new( count => 2 );
    my $hash = $seat -> to_hash();

    my $expect = { count => 2, passengerType => 'ADULT' };
    is_deeply $hash, $expect
        => 'got to_hash()';
}