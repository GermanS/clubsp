use Test::More tests =>4;

use strict;
use warnings;

use_ok('ClubSpain::XML::Olympia::Category');

my $category = ClubSpain::XML::Olympia::Category->new({
    CodigoCategoria => '2*',
    NombreCategoria => '2 *'
});
isa_ok($category, 'ClubSpain::XML::Olympia::Category');
is($category->CodigoCategoria, '2*', 'got CodigoCategoria');
is($category->NombreCategoria, '2 *', 'got NombreCategoria');
