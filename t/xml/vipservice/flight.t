use Test::More tests => 16;
use strict;
use warnings;
use utf8;

use_ok('ClubSpain::XML::VipService::Flight');

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
