use Test::More tests =>3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Province');

my $province = ClubSpain::XML::Terramar::Province->new({
    provincia => 'Alicante'
});

isa_ok($province, 'ClubSpain::XML::Terramar::Province');
is($province->provincia, 'Alicante', 'got alicante');
