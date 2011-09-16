use Test::More tests => 5;

use strict;
use warnings;

use_ok('ClubSpain::XML::VipService::Location');

my $location = ClubSpain::XML::VipService::Location->new(
    name => 'Moscow',
    code => 'MOW'
);
isa_ok($location, 'ClubSpain::XML::VipService::Location');
is($location->code, 'MOW', 'got code');
is($location->name, 'Moscow', 'got name');

{
    my $expect = { code => 'MOW', name => 'Moscow' };
    is_deeply($location->to_hash(), $expect, 'got to_hash()');
}
