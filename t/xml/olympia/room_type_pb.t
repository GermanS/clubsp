use Test::More tests => 5;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::RoomTypePB');

my $type = ClubSpain::XML::Olympia::RoomTypePB->new({
    CodigoTipoHabitacion      => '2005',
    DescripcionTipoHabitacion => 'Apartamento 2 Dormitorios',
    ApartamentoTipoReserva    => 'Y'
});

isa_ok($type, 'ClubSpain::XML::Olympia::RoomTypePB');
is($type->CodigoTipoHabitacion, '2005', 'got CodigoTipoHabitacion');
is($type->DescripcionTipoHabitacion, 'Apartamento 2 Dormitorios', 'got DescripcionTipoHabitacion');
is($type->ApartamentoTipoReserva, 'Y', 'got ApartamentoTipoReserva');
