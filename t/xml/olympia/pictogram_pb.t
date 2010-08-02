use Test::More tests => 5;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::PictogramPB');

my $pic = ClubSpain::XML::Olympia::PictogramPB->new({
    Codigo      => '28',
    Descripcion => 'MINICLUB',
    Url         => 'http://89.140.26.66/Simbolos/MiniClub.gif'
});

isa_ok($pic, 'ClubSpain::XML::Olympia::PictogramPB');
is($pic->Codigo, '28', 'got codigo');
is($pic->Descripcion, 'MINICLUB', 'got descripcion');
is($pic->Url, 'http://89.140.26.66/Simbolos/MiniClub.gif', 'got url');

