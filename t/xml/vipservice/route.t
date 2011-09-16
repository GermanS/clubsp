use Test::More tests => 8;
use strict;
use warnings;
use DateTime;

use_ok('ClubSpain::XML::VipService::Location');
use_ok('ClubSpain::XML::VipService::Route');

my $MOW = ClubSpain::XML::VipService::Location->new(
    code => 'MOW',
    name => 'Moscow'
);
my $BCN = ClubSpain::XML::VipService::Location->new(
    code => 'BCN',
    name => 'Barcelona'
);
my $date = DateTime->now();
my $route = ClubSpain::XML::VipService::Route->new(
    date          => $date,
    locationBegin => $MOW,
    locationEnd   => $BCN,
);

isa_ok($route, 'ClubSpain::XML::VipService::Route');
isa_ok($route->locationBegin, 'ClubSpain::XML::VipService::Location');
isa_ok($route->locationEnd,   'ClubSpain::XML::VipService::Location');
isa_ok($route->date, 'DateTime');
is_deeply($route->locationBegin, $MOW, 'got MOW');
is_deeply($route->locationEnd, $BCN, 'got BCN')


