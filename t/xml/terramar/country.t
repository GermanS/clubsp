use Test::More tests =>4;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Country');

my $object = ClubSpain::XML::Terramar::Country->new({
    id_zona_pais => '1',
    nombre => 'nombre'
});

isa_ok($object, 'ClubSpain::XML::Terramar::Country');
is($object->id_zona_pais, 1, 'got zona pais');
is($object->nombre, 'nombre', 'got nombre');
