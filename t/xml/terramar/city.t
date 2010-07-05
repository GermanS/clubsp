use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::City');

my $city = ClubSpain::XML::Terramar::City->new({
    poblacion => 'Benidorm'
});

isa_ok($city, 'ClubSpain::XML::Terramar::City');
is($city->poblacion, 'Benidorm', 'got poblacion');
