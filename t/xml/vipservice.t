use Test::More tests => 7;
use strict;
use warnings;
use utf8;
use_ok('ClubSpain::XML::VipService');
use_ok('ClubSpain::XML::VipService::Config');
use_ok('ClubSpain::XML::VipService::Seat');
use_ok('ClubSpain::XML::VipService::Location');
use_ok('ClubSpain::XML::VipService::Route');
use_ok('ClubSpain::XML::VipService::Flight');

use lib qw(t/lib);
use ClubSpain::Test;
my @sat = ClubSpain::Test->three_saturdays_ahead();

my $config = ClubSpain::XML::VipService::Config->new(
    locale              => 'ru',
    loginName           => 'dummy_loginname',
    password            => 'dummy_password',
    salesPointCode      => 'dummy_salesPointCode',
    corporateClientCode => 'dummy_corporateClientCode',
    wsdlfile            => 'root/vipservice/vip_service.wsdl',
    xsdfile             => 'root/vipservice/vip_service.xsd',
);
my $service = ClubSpain::XML::VipService->new(config => $config);
isa_ok($service, 'ClubSpain::XML::VipService');

my $seat = ClubSpain::XML::VipService::Seat->new( passenger => 'ADULT', count => 2 );

my $st_location = ClubSpain::XML::VipService::Location->new( code => 'MOW', name => 'Moscow' );
my $nd_location = ClubSpain::XML::VipService::Location->new( code => 'BCN', name => 'Barcelona' );

my $route1 = ClubSpain::XML::VipService::Route->new(
    date          => $sat[0],
    locationBegin => $st_location,
    locationEnd   => $nd_location,
);
my $route2 = ClubSpain::XML::VipService::Route->new(
    date          => $sat[2],
    locationBegin => $nd_location,
    locationEnd   => $st_location,
);

my $flight = ClubSpain::XML::VipService::Flight->new(
    route => [ $route1, $route2 ],
    seat  => [ $seat ]
);

my $response = $service->searchFlights($flight);

use Data::Dumper;
warn Dumper($response);

=head

    route => {
        segment => {
            date      => '2011-11-11T00:00:00',
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
        }
    },
    seats => {
        seatPreferences => {
            count         => 1,
            passengerType => 'ADULT'
        }
    },
    skipConnected => 'true',
    serviceClass  => 'ECONOMY'

=cut
