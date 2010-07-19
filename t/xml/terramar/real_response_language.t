use Test::More tests => 3;

use strict;
use warnings;

use File::Slurp;

use_ok('ClubSpain::XML::Terramar::Language');
use_ok('ClubSpain::XML::Terramar::Response::Language');

my $xml = read_file('t/var/terramar/response_language.xml');
my $result = ClubSpain::XML::Terramar::Response::Language->parse($xml);

is_deeply($result, &expected(), 'compare objects');

sub expected {
    my @expect = ({
    id_idioma     => 0,
    nombre_idioma =>'Espanol',
    logo_idioma   =>'http://www.orbisbooking.com/owbooking/idiomas/banderas/es_flag.gif'
  },
  {
    id_idioma     => 3,
    nombre_idioma => 'Ingles',
    logo_idioma   => 'http://www.orbisbooking.com/owbooking/idiomas/banderas/uk_flag.gif'
  });

    my @objects;
    push @objects, new ClubSpain::XML::Terramar::Language($_)
        foreach (@expect);

    return \@objects;
}
