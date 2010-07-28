use Test::More tests => 4;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::Coast');

my $coast = ClubSpain::XML::Olympia::Coast->new({
    Codigo => '01',
    Descripcion => 'Costa del Sol'
});

isa_ok($coast, 'ClubSpain::XML::Olympia::Coast');
is($coast->Codigo, '01', 'got codigo');
is($coast->Descripcion, 'Costa del Sol', 'got descripcion');
