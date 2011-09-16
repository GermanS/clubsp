use Test::More tests => 9;
use strict;
use warnings;
use DateTime;

use_ok('ClubSpain::XML::VipService::Location');
use_ok('ClubSpain::XML::VipService::Route');

use lib qw(t/lib);
use ClubSpain::Test;
my @saturdays = ClubSpain::Test->three_saturdays_ahead();

my $MOW = ClubSpain::XML::VipService::Location->new(
    code => 'MOW',
    name => 'Moscow'
);
my $BCN = ClubSpain::XML::VipService::Location->new(
    code => 'BCN',
    name => 'Barcelona'
);
my $route = ClubSpain::XML::VipService::Route->new(
    date          => $saturdays[0],
    locationBegin => $MOW,
    locationEnd   => $BCN,
);

isa_ok($route, 'ClubSpain::XML::VipService::Route');
isa_ok($route->locationBegin, 'ClubSpain::XML::VipService::Location');
isa_ok($route->locationEnd,   'ClubSpain::XML::VipService::Location');
isa_ok($route->date, 'DateTime');
is_deeply($route->locationBegin, $MOW, 'got MOW');
is_deeply($route->locationEnd, $BCN, 'got BCN');

#to_hash
my $expect = {
    date      => $saturdays[0]->iso8601(),
    timeBegin => 0,
    timeEnd   => 0,
    locationBegin => {
        code => 'MOW',
        name => 'Moscow',
    },
    locationEnd => {
        code => 'BCN',
        name => 'Barcelona',
    }
};

is_deeply($route->to_hash(), $expect, 'got to_hash()');
