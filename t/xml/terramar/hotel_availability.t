use Test::More tests => 5;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::HotelAvailability');

my $availability = ClubSpain::XML::Terramar::HotelAvailability->new({
    fecha_desde    => 'desde',
    fecha_hasta    => 'hasta',
    disponibilidad => 'disponibilidad'
});

isa_ok($availability, 'ClubSpain::XML::Terramar::HotelAvailability');
is($availability->fecha_desde, 'desde', 'got fecha desde');
is($availability->fecha_hasta, 'hasta', 'got fecha hasta');
is($availability->disponibilidad, 'disponibilidad', 'got disponibilidad');
