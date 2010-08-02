use Test::More tests => 5;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::Pictogram');

my $pic = ClubSpain::XML::Olympia::Pictogram->new({
    Codigo      => '26',
    Descripcion => 'GARAJE',
    Url         => 'http://89.140.26.66/Simbolos/Garaje.gif',
});

isa_ok($pic, 'ClubSpain::XML::Olympia::Pictogram');
is($pic->Codigo, '26', 'got codigo');
is($pic->Descripcion, 'GARAJE', 'got descripcion');
is($pic->Url, 'http://89.140.26.66/Simbolos/Garaje.gif', 'got url');
