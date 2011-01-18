package ClubSpain::Design::FareClass;

use Moose;
use namespace::autoclean;
use utf8;

use parent qw(ClubSpain::Design::Base);

use ClubSpain::Types;
use ClubSpain::Exception;

has 'id'            => ( is => 'ro' );
has 'code'          => ( is => 'ro', required => 1, isa => 'AlphaLength1' );
has 'name'          => ( is => 'ro', required => 1, isa => 'StringLength2to255' );
has 'is_published'  => ( is => 'ro', required => 1 );

1;
