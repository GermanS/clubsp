use Test::More tests => 4;
use strict;
use warnings;

use_ok('ClubSpain::XML::VipService::Seat');

my $seat = ClubSpain::XML::VipService::Seat->new(
    passenger => 'ADULT',
    count     => 1
);
isa_ok($seat, 'ClubSpain::XML::VipService::Seat');
is($seat->passenger, 'ADULT', 'got passenger');
is($seat->count, 1, 'got count');
