use Test::More tests => 4;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::Language');

my $lang = ClubSpain::XML::Olympia::Language->new({
    Codigo      => '01',
    Descripcion => 'Spanish'
});

isa_ok($lang, 'ClubSpain::XML::Olympia::Language');
is($lang->Codigo, '01', 'got codigo');
is($lang->Descripcion, 'Spanish', 'got Descripcion');
