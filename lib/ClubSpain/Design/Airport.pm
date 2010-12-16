package ClubSpain::Design::Airport;

use Moose;
use namespace::autoclean;
use utf8;

use parent qw(ClubSpain::Design::Base);

use Scalar::Util qw(blessed);
use ClubSpain::Common qw(minify);
use ClubSpain::Types;
use ClubSpain::Exception;

has 'id'            => ( is => 'ro' );
has 'city_id'       => ( is => 'ro', required => 1 );
has 'iata'          => ( is => 'ro', required => 1, isa => 'AlphaLength3' );
has 'icao'          => ( is => 'ro', required => 1, isa => 'AlphaLength4' );
has 'name'          => ( is => 'ro', required => 1, isa => 'StringLength2to255' );
has 'is_published'  => ( is => 'ro', required => 1 );



sub BUILDARGS {
    my ($class,  %param) = @_;

    $param{'name'} = minify($param{'name'});

    return \%param;
}


1;
