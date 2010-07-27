use Test::More tests => 4;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::RoomType');

my $type = ClubSpain::XML::Olympia::RoomType->new({
    CodigoTipoHabitacion   => 1234,
    DescripcionTipoHabitacion => 'SUIT REAL'
});

isa_ok($type, 'ClubSpain::XML::Olympia::RoomType');
is($type->CodigoTipoHabitacion, 1234, 'got CodigoTipoHabitacion');
is($type->DescripcionTipoHabitacion, 'SUIT REAL', 'got DescripcionTipoHabitacion');
