use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::Service');

my $service = ClubSpain::XML::Olympia::Service->new({
    CodigoProveedor => 'CS009003'
});

isa_ok($service, 'ClubSpain::XML::Olympia::Service');
is($service->CodigoProveedor, 'CS009003', 'got CodigoProveedor');
