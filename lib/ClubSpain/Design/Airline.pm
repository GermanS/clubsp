package ClubSpain::Design::Airline;

use Moose;
use namespace::autoclean;
use utf8;

use parent qw(ClubSpain::Design::Base);

use Scalar::Util qw(blessed);
use ClubSpain::Common qw(minify);
use ClubSpain::Types;
use ClubSpain::Exception;

has 'id'            => ( is => 'ro' );
has 'iata'          => ( is => 'ro', required => 1, isa => 'AlphaNumericLength2' );
has 'icao'          => ( is => 'ro', required => 1, isa => 'AlphaLength3' );
has 'name'          => ( is => 'ro', required => 1, isa => 'StringLength2to255' );
has 'is_published'  => ( is => 'ro', required => 1 );



1;
