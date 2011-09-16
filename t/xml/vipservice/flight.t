use Test::More tests => 24;
use strict;
use warnings;
use utf8;

use_ok('ClubSpain::XML::VipService::Flight');
use_ok('ClubSpain::XML::VipService::Route');
use_ok('ClubSpain::XML::VipService::Location');

use lib qw(t/lib);
use ClubSpain::Test;
my @saturdays = ClubSpain::Test->three_saturdays_ahead();

{
    my $flight = ClubSpain::XML::VipService::Flight->new();
    isa_ok($flight, 'ClubSpain::XML::VipService::Flight');
    is($flight->eticketsOnly,  'true', 'got default eticketsOnly');
    is($flight->mixedVendors,  'true', 'got default mixedVendors');
    is($flight->skipConnected, 'true', 'got default skipConnected');
    is($flight->serviceClass,  'ECONOMY', 'got default serviceClass');
}

{
    my @fields = qw(eticketsOnly mixedVendors skipConnected);
    foreach my $field (@fields) {
        my $flight = ClubSpain::XML::VipService::Flight->new(
            $field => 'false',
        );

        isa_ok($flight, 'ClubSpain::XML::VipService::Flight');
        is($flight->$field, 'false', "got $field");
    }

    #negative test
    foreach my $field ((@fields, "serviceClass")) {
        eval {
            my $flight = ClubSpain::XML::VipService::Flight->new(
                $field => 'string',
            );
            fail("suddenly this test passes");
        };

        if ($@) {
            pass("Wrong type constraint $field");
        }
    }
}

{
    my $MOW = ClubSpain::XML::VipService::Location->new(
        code => 'MOW',
        name => 'Moscow'
    );
    my $BCN = ClubSpain::XML::VipService::Location->new(
        code => 'BCN',
        name => 'Barcelona'
    );

    my $route1 = ClubSpain::XML::VipService::Route->new(
        locationBegin => $MOW,
        locationEnd   => $BCN,
        date          => $saturdays[0],
    );
    my $route2 = ClubSpain::XML::VipService::Route->new(
        locationBegin => $BCN,
        locationEnd   => $MOW,
        date          => $saturdays[1]
    );

    my $flight = ClubSpain::XML::VipService::Flight->new(
        route         => [$route1, $route2],
        eticketsOnly  => 'true',
        mixedVendors  => 'false',
        skipConnected => 'false',
        serviceClass  => 'ECONOMY',
    );

    isa_ok($flight, 'ClubSpain::XML::VipService::Flight');
    is($flight->eticketsOnly, 'true', 'got eticketsOnly');
    is($flight->mixedVendors, 'false', 'got mixedVendors');
    is($flight->skipConnected, 'false', 'got skipConnected');
    is($flight->serviceClass, 'ECONOMY', 'got class of service');
    is_deeply($flight->route, [$route1, $route2], 'got route');
}
