use Test::More tests => 4;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::BoardTypePB');

my $type = ClubSpain::XML::Olympia::BoardTypePB->new({
    RegimenCodigo   => 'HB',
    TraduccionTexto => 'Half Board'
});

isa_ok($type, 'ClubSpain::XML::Olympia::BoardTypePB');
is($type->RegimenCodigo,   'HB', 'got RegimenCodigo');
is($type->TraduccionTexto, 'Half Board', 'got TraduccionTexto');
