package ClubSpain::Design::Manufacturer;

use Moose;
use namespace::autoclean;
use utf8;

use parent qw(ClubSpain::Design::Base);

use Scalar::Util qw(blessed);
use ClubSpain::Types;
use ClubSpain::Exception;

has 'id'   => ( is => 'ro' );
has 'code' => ( is => 'ro', required => 1, isa => 'StringLength2to255' );
has 'name' => ( is => 'ro', required => 1, isa => 'StringLength2to255' );



1;
