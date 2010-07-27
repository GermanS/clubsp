use Test::More tests => 4;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::BoardType');

my $type = ClubSpain::XML::Olympia::BoardType->new({
    RegimenCodigo => 'HB',
    RegimenDescripcion => 'Half board'
});

isa_ok($type, 'ClubSpain::XML::Olympia::BoardType');
is($type->RegimenCodigo, 'HB', 'got RegimenCodigo');
is($type->RegimenDescripcion, 'Half board', 'got RegimenDescripcion');
