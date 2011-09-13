use Test::More tests => 3;
use strict;
use warnings;
use utf8;
use lib qw(t/lib);
use_ok('ClubSpain::XML::VipService');
use_ok('ClubSpain::XML::VipService::Config');

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

my $response = $service->searchFlights(
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
);
