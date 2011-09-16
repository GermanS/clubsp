use Test::More tests => 8;
use strict;
use warnings;

use_ok('ClubSpain::XML::VipService::Seat');

{
    my $seat = ClubSpain::XML::VipService::Seat->new();
    isa_ok($seat, 'ClubSpain::XML::VipService::Seat');
    is($seat->passenger, 'ADULT', 'got passenger');
    is($seat->count, 0, 'got count');
}

{
    my $seat = ClubSpain::XML::VipService::Seat->new(
        passenger => 'ADULT',
        count     => 1
    );
    isa_ok($seat, 'ClubSpain::XML::VipService::Seat');
    is($seat->passenger, 'ADULT', 'got passenger');
    is($seat->count, 1, 'got count');
}

#to_hash()
{
    my $seat = ClubSpain::XML::VipService::Seat->new(count => 2);
    my $hash = $seat->to_hash();

    my $expect = { count => 2, passengerType => 'ADULT' };
    is_deeply($hash, $expect, 'got to_hash()');
}



