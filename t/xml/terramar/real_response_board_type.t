use Test::More tests => 3;

use strict;
use warnings;

use_ok('ClubSpain::XML::Terramar::BoardType');
use_ok('ClubSpain::XML::Terramar::Response::BoardType');
use File::Slurp qw(read_file);
 
my @expected =  (
  {
    id_tipo_suplemento =>1,
    nombre =>'Accommodation only',
  },
  {
    id_tipo_suplemento =>2,
    nombre =>'Bed and Breakfast',
  },
  {
    id_tipo_suplemento =>3,
    nombre =>'Half Board',
  },
  {
    id_tipo_suplemento =>4,
    nombre =>'Full Board',
  },
  {
    id_tipo_suplemento =>5,
    nombre =>'All Inclusive',
  },
  {
    id_tipo_suplemento =>269,
    nombre =>'Silver Half Board',
  },
  {
    id_tipo_suplemento =>271,
    nombre =>'Golden All Inclusive',
  },
  {
    id_tipo_suplemento =>270,
    nombre =>'Silver Full Board',
  },
  {
    id_tipo_suplemento =>292,
    nombre =>'Half Board Plus',
  },
  {
    id_tipo_suplemento =>314,
    nombre =>'Extra service'
  },
  {
    id_tipo_suplemento =>315,
    nombre =>'Excursion',
  },
  {
    id_tipo_suplemento =>323,
    nombre =>'Half Board Deluxe',
  },
  {
    id_tipo_suplemento =>329,
    nombre =>'Full Board Plus'
  },
  {
    id_tipo_suplemento =>350,
    nombre =>'All Inclusive Plus',
  },
  {
    id_tipo_suplemento =>357,
    nombre =>'Half Board Premium',
  },
  {
    id_tipo_suplemento =>366,
    nombre =>'Free breakfast buffet',
  },
  {
    id_tipo_suplemento =>391,
    nombre =>'All Inclusive Club',
  },
  {
    id_tipo_suplemento =>394,
    nombre =>'All Inclusive Light',
  },
  {
    id_tipo_suplemento =>421,
    nombre =>'Half Board GrandLuxe',
  },
  {
    id_tipo_suplemento =>422,
    nombre =>'Half Board Standard',
  },
  {
    id_tipo_suplemento =>434,
    nombre =>'Supl. Half Board (Children)',
  },
  {
    id_tipo_suplemento =>442,
    nombre =>'All Inclusive Elite',
  },
  {
    id_tipo_suplemento =>471,
    nombre =>'Half Board Premium',
  },
  {
    id_tipo_suplemento =>470,
    nombre =>'All Inclusive Premium',
  },
  {
    id_tipo_suplemento =>499,
    nombre =>'',
  },
  {
    id_tipo_suplemento =>504,
    nombre =>'All Inclusive Superior',
  },
  {
    id_tipo_suplemento =>508,
    nombre =>'Half Board a la carte',
  },
  {
    id_tipo_suplemento =>624,
    nombre =>'All Inclusive Yellow',
  },
  {
    id_tipo_suplemento =>625,
    nombre =>'All Inclusive Green',
  },
  {
    id_tipo_suplemento =>658,
    nombre =>'All Inclusive Deluxe',
  },
  {
    id_tipo_suplemento =>708,
    nombre =>'New Years Eve Gala Dinner Adult (in HB & PC)',
  },
  {
    id_tipo_suplemento =>709,
    nombre =>'New Years Eve Gala Dinner Child (in HB & PC)',
  },
  {
    id_tipo_suplemento =>717,
    nombre =>'Restaurant Dinner Buffet "EL BERNEGAL"(on BB basis)',
  }
);

my @objects;
push @objects, new ClubSpain::XML::Terramar::BoardType($_)
    foreach  (@expected);

my $xml = read_file('t/var/terramar/response_board_type.xml');
my $result = ClubSpain::XML::Terramar::Response::BoardType->parse($xml);

is_deeply($result, \@objects, 'compare board types');
