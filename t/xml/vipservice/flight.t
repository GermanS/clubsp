use Test::More tests => 26;
use strict;
use warnings;
use utf8;

use_ok('ClubSpain::XML::VipService::Flight');
use_ok('ClubSpain::XML::VipService::Route');
use_ok('ClubSpain::XML::VipService::Location');
use_ok('ClubSpain::XML::VipService::Seat');

use lib qw(t/lib);
use ClubSpain::Test;
my @saturdays = ClubSpain::Test -> three_saturdays_ahead();

{
    my $flight = ClubSpain::XML::VipService::Flight -> new();
    isa_ok($flight, 'ClubSpain::XML::VipService::Flight');

    is $flight -> eticketsOnly,  'true'
        => 'got default eticketsOnly';

    is $flight -> mixedVendors,  'true'
        => 'got default mixedVendors';

    is $flight -> skipConnected, 'false'
        => 'got default skipConnected';
    is $flight -> serviceClass,  'ECONOMY'
        => 'got default serviceClass';
}

{
    my @fields = qw(eticketsOnly mixedVendors skipConnected);
    foreach my $field (@fields) {
        my $flight = ClubSpain::XML::VipService::Flight -> new(
            $field => 'false',
        );

        isa_ok($flight, 'ClubSpain::XML::VipService::Flight');

        is $flight -> $field, 'false'
            => "got $field";
    }

    #negative test
    foreach my $field ((@fields, "serviceClass")) {
        eval {
            my $flight = ClubSpain::XML::VipService::Flight -> new(
                $field => 'string',
            );
            fail( "suddenly this test passes" );
        };

        if ($@) {
            pass("Wrong type constraint $field");
        }
    }
}

{
    my $MOW = ClubSpain::XML::VipService::Location -> new(
        code => 'MOW',
        name => 'Moscow'
    );
    my $BCN = ClubSpain::XML::VipService::Location -> new(
        code => 'BCN',
        name => 'Barcelona'
    );
    my $adult = ClubSpain::XML::VipService::Seat -> new(
        passenger => 'ADULT',
        count     => 1
    );
    my $child = ClubSpain::XML::VipService::Seat -> new(
        passenger => 'CHILD',
        count     => 1
    );
    my $infant = ClubSpain::XML::VipService::Seat -> new(
        passenger => 'INFANT',
        count     => 1
    );
    my $route1 = ClubSpain::XML::VipService::Route -> new(
        locationBegin => $MOW,
        locationEnd   => $BCN,
        date          => $saturdays[0],
    );
    my $route2 = ClubSpain::XML::VipService::Route -> new(
        locationBegin => $BCN,
        locationEnd   => $MOW,
        date          => $saturdays[1]
    );

    my $flight = ClubSpain::XML::VipService::Flight -> new(
        route         => [$route1, $route2],
        seat          => [$adult, $child, $infant],
        eticketsOnly  => 'true',
        mixedVendors  => 'false',
        skipConnected => 'false',
        serviceClass  => 'ECONOMY',
    );

    isa_ok($flight, 'ClubSpain::XML::VipService::Flight');

    is $flight -> eticketsOnly, 'true'
        => 'got eticketsOnly';

    is $flight -> mixedVendors, 'false'
        => 'got mixedVendors';

    is $flight -> skipConnected, 'false'
        => 'got skipConnected';

    is $flight -> serviceClass, 'ECONOMY'
        => 'got class of service';

    is_deeply $flight -> route, [$route1, $route2]
        => 'got route';

    #to_hash
    {
        my $expect = {
            eticketsOnly  => 'true',
            mixedVendors  => 'false',
            skipConnected => 'false',
            serviceClass  => 'ECONOMY',
            route => {
                segment => [{
                    locationBegin => {
                        code => 'MOW',
                        name => 'Moscow'
                    },
                    locationEnd   => {
                        code => 'BCN',
                        name => 'Barcelona'
                    },
                    date => $saturdays[0] -> iso8601,
                    timeBegin => 0,
                    timeEnd   => 0,
                }, {
                    locationBegin => {
                        code => 'BCN',
                        name => 'Barcelona'
                    },
                    locationEnd   => {
                        code => 'MOW',
                        name => 'Moscow'
                    },
                    date => $saturdays[1] -> iso8601,
                    timeBegin => 0,
                    timeEnd   => 0,
                }]
            },
            seats => {
                seatPreferences => [{
                    count => 1,
                    passengerType => 'ADULT'
                }, {
                    count => 1,
                    passengerType => 'CHILD'
                }, {
                    count => 1,
                    passengerType => 'INFANT'
                }]
            },
        };

        is_deeply $flight -> to_hash(), $expect
            => 'got to_hash()';
    }
}


