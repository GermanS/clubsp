use Test::More tests => 5;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::Language');

my $lang = ClubSpain::XML::Terramar::Language->new({
    id_idioma => 0,
    nombre_idioma => 'Español',
    logo_idioma => 'http://www.orbisbooking.com/owbooking/idiomas/banderas/es_flag.gif'
});

isa_ok($lang, 'ClubSpain::XML::Terramar::Language');
is($lang->id_idioma, 0, 'got idioma');
is($lang->nombre_idioma, 'Español', 'got nombre');
is($lang->logo_idioma, 'http://www.orbisbooking.com/owbooking/idiomas/banderas/es_flag.gif', 'get logo');
