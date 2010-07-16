use Test::More tests => 3;

use strict;
use warnings;

use File::Slurp;

use_ok('ClubSpain::XML::Terramar::City');
use_ok('ClubSpain::XML::Terramar::Response::City');

my @expected = (
  { poblacion => 'CALAFELL' },
  { poblacion => 'CAMBRILS' },
  { poblacion => 'COMARRUGA' },
  { poblacion => 'COSTA DORADA' },
  { poblacion => 'EL VENDRELL' },
  { poblacion => 'LA PINEDA' },
  { poblacion => 'MIAMI PLAYA (TARRAGONA)' },
  { poblacion => 'MONTBRIO DEL CAMP' },
  { poblacion => 'SALOU' },
);


my @objects;
push @objects, new ClubSpain::XML::Terramar::City($_)
    foreach (@expected);

my $xml = read_file('t/var/terramar/response_city.xml');
my $result = ClubSpain::XML::Terramar::Response::City->parse($xml);

is_deeply($result, \@objects, 'compare objects');
