use Test::More tests => 3;

use strict;
use warnings;

use_ok( 'ClubSpain::XML::VipService::Import::Duration' );
use_ok( 'ClubSpain::XML::VipService::Import::Request' );

my $request = ClubSpain::XML::VipService::Import::Request -> new(
    duration => ClubSpain::XML::VipService::Import::Duration -> new(
        start       => '2013-03-17',
        end         => '2013-03-17',
        dates       => [ qw(7) ],
        origin      => 'MOW',
        destination => 'BCN'
    )
);

isa_ok( $request, 'ClubSpain::XML::VipService::Import::Request' );

my @responses = $request -> launch();
