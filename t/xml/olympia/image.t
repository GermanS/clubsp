use Test::More tests => 5;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::Image');

my $image = ClubSpain::XML::Olympia::Image->new({
    Codigo  => 'CS000150',
    Orden   => '0',
    Url     => 'http://89.140.26.66/Fotos/PlayaBonita/facha.jpg'
});

isa_ok($image, 'ClubSpain::XML::Olympia::Image');
is($image->Codigo, 'CS000150', 'got Codigo');
is($image->Orden, '0', 'got orden');
is($image->Url, 'http://89.140.26.66/Fotos/PlayaBonita/facha.jpg', 'got url');
